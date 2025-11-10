`timescale 1ns / 1ps

module tb_hidden2hidden;

    // ============================================================
    // Parámetros del Testbench
    // ============================================================
    localparam integer INPUT_SIZE  = 20;
    localparam integer HIDDEN_SIZE = 20;
    localparam integer BW_IN       = 32;
    localparam integer BW_OUT      = 32;
    localparam integer CLK_PERIOD  = 10; // Periodo del reloj en ns

    // ============================================================
    // Señales del Testbench
    // ============================================================
    reg                          clk;
    reg                          rst_n;
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
        $display("Formato de datos asumido: Punto fijo Q17.15");
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
        // Como ejemplo, creamos un vector donde cada elemento es 0.1
        
        $display("[%0t ns] Aplicando vector de entrada de prueba...", $time);
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
             tb_input_vector_bus[(INPUT_SIZE-1-i)*BW_IN +: BW_IN] = 32'sd16384;
        end 

        // Mostramos el vector de entrada completo en formato decimal
        $display("\n--- Vector de Entrada Aplicado (Decimal) ---");
        for (i = 0; i < INPUT_SIZE; i = i + 1) begin
            // Extraemos el valor entero del bus (MSB-first)
            real_val = $signed(tb_input_vector_bus[(INPUT_SIZE-1-i)*BW_IN +: BW_IN]);
            // Convertimos a real y mostramos
            $display("input[%2d]: %10d  =>  %f", i, real_val, real_val / 32768.0);
        end

        // --- 3. Esperar un tiempo para la propagación y observar la salida ---
        // Tu módulo es combinacional, por lo que el resultado es casi instantáneo.
        // Esperamos un ciclo de reloj para asegurar la estabilidad en la visualización.
        #CLK_PERIOD;

        // Mostramos el vector de salida completo en formato decimal
        $display("\n[%0t ns] --- Vector de Salida Generado (Decimal) ---", $time);
        for (i = 0; i < HIDDEN_SIZE; i = i + 1) begin
            real_val = $signed(tb_output_vector_bus[(HIDDEN_SIZE-1-i)*BW_OUT +: BW_OUT]);
            $display("output[%2d]:  =>  %f", i, real_val / 32768.0);
        end

        // --- 4. Finalizar simulación ---
        // Espera adicional para asegurar que la consola muestre todo antes de parar
        #100;

        $display("\nSimulación completada.");
        $stop;
    end

endmodule
