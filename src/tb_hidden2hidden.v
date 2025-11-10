module tb_hidden2hidden;

    // ============================================================
    // Parámetros del Testbench
    // ============================================================
    localparam integer INPUT_SIZE  = 20;
    localparam integer HIDDEN_SIZE = 20;
    localparam integer BW_IN       = 32;
    localparam integer BW_OUT      = 32;
    localparam integer CLK_PERIOD  = 10; // Periodo del reloj en ns

    // --- CAMBIO: Parámetros de Punto Fijo ---
    localparam integer FRAC_BITS         = 20;
    localparam real    SCALE_FACTOR_REAL = 1.0 * (2**FRAC_BITS); // 1048576.0
    
    // El valor 0.5 en el formato Q(BW_IN - 1 - FRAC_BITS).FRAC_BITS
    // 0.5 * (2**20) = 524288
    localparam integer INT_VAL_0_5       = (2**FRAC_BITS) / 2; 

    // ============================================================
    // Señales del Testbench
    // ============================================================
    reg                            clk;
    reg                            rst_n;
    reg  signed [INPUT_SIZE*BW_IN-1:0]   tb_input_vector_bus;
    wire signed [HIDDEN_SIZE*BW_OUT-1:0] tb_output_vector_bus;

    // ============================================================
    // Instancia del Módulo Bajo Prueba (DUT)
    // ============================================================
    hidden2hidden_1x20_20x20 #(
        .INPUT_SIZE(INPUT_SIZE),
        .HIDDEN_SIZE(HIDDEN_SIZE),
        .BW_IN(BW_IN),
        .BW_OUT(BW_OUT)
    ) dut (
        .input_vector_bus(tb_input_vector_bus),
        .output_vector_bus(tb_output_vector_bus)
    );

    // ============================================================
    // Generador de Reloj
    // ============================================================
    always begin
        clk = 1'b0; #(CLK_PERIOD/2);
        clk = 1'b1; #(CLK_PERIOD/2);
    end

    // ============================================================
    // Procedimiento Principal de Prueba
    // ============================================================
    integer i; // Variable para bucles
    real    real_val; // Variable para conversión a decimal
    initial begin
        
        $display("==================================================");
        $display("Inicio de la simulación del testbench para hidden2hidden");
        // --- CAMBIO: Mensaje de formato dinámico ---
        $display("Formato de datos asumido: Punto fijo Q%0d.%0d", BW_IN - 1 - FRAC_BITS, FRAC_BITS);
        $display("==================================================");

        // --- 1. Inicialización y Reset ---
        rst_n = 1'b0; // Reset activo bajo
        tb_input_vector_bus = 0;
        @(posedge clk);
        @(posedge clk);
        rst_n = 1'b1; // Liberar el reset
        $display("[%0t ns] Reset liberado. El sistema está operativo.", $time);
        
        @(posedge clk);

        // --- 2. Aplicar un vector de prueba ---
        // Aplicando un vector donde cada elemento es 0.5
        
        $display("[%0t ns] Aplicando vector de entrada de prueba...", $time);
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
             // --- CAMBIO: Usar el valor entero Q12.20 para 0.5 ---
            tb_input_vector_bus[(INPUT_SIZE-1-i)*BW_IN +: BW_IN] = INT_VAL_0_5;
        end 

        // Mostramos el vector de entrada completo en formato decimal
        $display("\n--- Vector de Entrada Aplicado (Decimal) ---");
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
            // Extraemos el valor entero del bus (MSB-first)
            real_val = $signed(tb_input_vector_bus[(INPUT_SIZE-1-i)*BW_IN +: BW_IN]);
            // Convertimos a real y mostramos
            // --- CAMBIO: Usar el factor de escala correcto ---
            $display("input[%2d]: %10d  =>  %f", i, real_val, real_val / SCALE_FACTOR_REAL);
        end

        // --- 3. Esperar un tiempo para la propagación y observar la salida ---
        #CLK_PERIOD;

        // Mostramos el vector de salida completo en formato decimal
        $display("\n[%0t ns] --- Vector de Salida Generado (Decimal) ---", $time);
        for (i = 0; i < HIDDEN_SIZE; i = i + 1) begin
            real_val = $signed(tb_output_vector_bus[(HIDDEN_SIZE-1-i)*BW_OUT +: BW_OUT]);
            // --- CAMBIO: Usar el factor de escala correcto ---
            $display("output[%2d]:  =>  %f", i, real_val / SCALE_FACTOR_REAL);
        end

        // --- 4. Finalizar simulación ---
        #100;

        $display("\nSimulación completada.");
        $stop;
    end

endmodule