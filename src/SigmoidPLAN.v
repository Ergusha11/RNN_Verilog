`timescale 1ns/1ps

module Sigmoid_PLAN(
    input  signed [31:0] x,   // Entrada Q17.15
    output reg   [31:0] y     // Salida Q1.15
);

    // --- Límites Q17.15 ---
    localparam signed [31:0] LIM_5 =  32'sd163840; // 5.0
    localparam signed [31:0] LIM_2 =  32'sd77824;  // 2.375
    localparam signed [31:0] LIM_1 =  32'sd32768;  // 1.0

    // --- Constantes de salida Q1.15 ---
    localparam signed [31:0] Y_ONE  = 32'sd32768; // 1.0
    localparam signed [31:0] Y_ZERO = 32'sd0;

    // --- Constantes de offset (Q1.15) ---
    localparam signed [31:0] RAMP1_OFFSET = 32'sd27648; // 0.84375
    localparam signed [31:0] RAMP2_OFFSET = 32'sd20480; // 0.625
    localparam signed [31:0] RAMP3_OFFSET = 32'sd16384; // 0.5

    // --- Valor absoluto ---
    wire signed [31:0] x_abs = (x < 0) ? -x : x;

    // --- Rampas (Entrada y salida en Q17.15) ---
    // Pendiente 1: 1/32 = 2^-5
    wire signed [32:0] ramp1_term1 = (x_abs >>> 5);
    // Pendiente 2: 1/8 = 2^-3
    wire signed [32:0] ramp2_term1 = (x_abs >>> 3);
    // Pendiente 3: 1/4 = 2^-2
    wire signed [32:0] ramp3_term1 = (x_abs >>> 2);

    // Las salidas de las rampas están en formato Q1.15
    wire signed [31:0] y_ramp1 = ramp1_term1[31:0] + RAMP1_OFFSET;
    wire signed [31:0] y_ramp2 = ramp2_term1[31:0] + RAMP2_OFFSET;
    wire signed [31:0] y_ramp3 = ramp3_term1[31:0] + RAMP3_OFFSET;

    // --- Multiplexor piecewise ---
    always @(*) begin
        if (x_abs >= LIM_5) // Saturación
            y = (x >= 0) ? Y_ONE : Y_ZERO;
        else if (x_abs >= LIM_2)
            y = (x >= 0) ? y_ramp1 : (Y_ONE - y_ramp1);
        else if (x_abs >= LIM_1)
            y = (x >= 0) ? y_ramp2 : (Y_ONE - y_ramp2);
        else
            y = (x >= 0) ? y_ramp3 : (Y_ONE - y_ramp3);
    end

endmodule
