`timescale 1ns/1ps

/*
 * Testbench para el módulo Tanh con aproximación lineal.
 * - Barre un rango de valores de entrada en 'real'.
 * - Convierte 'real' a punto fijo (Q17.15) para el UUT.
 * - Recibe la salida en punto fijo (Q1.15) del UUT.
 * - Convierte la salida de vuelta a 'real'.
 * - Escribe los valores (x_real, y_real_hw) en un CSV para graficar.
 */
module tb_tanh;

    // --- Parámetros de Punto Fijo ---
    // DEBEN COINCIDIR CON EL MÓDULO Tanh
    localparam FRAC_BITS_IN  = 15; // Para Q17.15
    localparam FRAC_BITS_OUT = 15; // Para Q1.15
    
    // El '2.0' asegura que la operación se haga en 'real'
    localparam real SCALE_IN  = 2.0**FRAC_BITS_IN;  // 32768.0
    localparam real SCALE_OUT = 2.0**FRAC_BITS_OUT; // 32768.0

    // --- Variables del Test ---
    reg  signed [31:0] x_int; // Entrada Q17.15 para el UUT
    wire signed [31:0] y_int; // Salida Q1.15 del UUT

    real x_real; // Valor real de entrada
    real y_real; // Valor real de salida
    
    integer file;
    integer i;

    // --- Instancia del Módulo (Unit Under Test) ---
    // Asegúrate de que el nombre "Tanh" coincida con tu módulo
    Tanh uut (
        .x(x_int),
        .y(y_int)
    );

    initial begin
        // --- Setup ---
        file = $fopen("tanh_data.csv", "w");
        $fdisplay(file, "x_real,y_real_hw"); // Encabezado CSV
        $display("Iniciando simulación Tanh...");
        $display("Factor de escala IN (Q17.15): %f", SCALE_IN);
        $display("Factor de escala OUT (Q1.15): %f", SCALE_OUT);

        // --- Bucle de Simulación ---
        // Iteramos sobre un rango real. Tu módulo satura en +/- 2.375,
        // así que un rango de -8.0 a 8.0 es más que suficiente.
        // Iremos de -8.0 a ~8.0 en pasos de 0.0625
        // (i = -128*0.0625 = -8.0) a (i = 127*0.0625 = 7.9375)
        for (i = -128; i < 128; i = i + 1) begin
            
            x_real = i * 0.0625; // x_real = -8.0, -7.9375, ... , 7.9375

            // 1. Convertir de Real a Fixed-Point (Q17.15)
            x_int = $rtoi(x_real * SCALE_IN);
            
            #1; // Esperar 1ns para que la lógica combinacional se propague
            
            // 2. Convertir de Fixed-Point (Q1.15) a Real
            // $itor convierte el vector 'signed' en un 'integer' (que es signed)
            y_real = $itor(y_int) / SCALE_OUT;

            // 3. Guardar en CSV
            $fdisplay(file, "%f,%f", x_real, y_real);
        end

        // --- Cierre ---
        $fclose(file);
        $display("Simulación completa. Datos exportados en tanh_data.csv");
        $stop;
    end

endmodule