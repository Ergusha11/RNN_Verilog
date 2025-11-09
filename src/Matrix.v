// ============================================================
// VectorScalar.v
// Multiplica un escalar por un vector 
// Orden: MSB-first (el elemento 0 está en los bits más altos)
// ============================================================
module VectorScalar #(
    parameter integer N       = 4,
    parameter integer BW      = 16,
    parameter integer BW_OUT  = 32
)(
    input  wire signed [BW-1:0]       scalar,
    input  wire signed [N*BW-1:0]     vectorA_bus,
    output wire signed [N*BW_OUT-1:0] result_bus
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : MUL
            // MSB-first: el primer elemento (i=0) usa los bits más altos
            assign result_bus[(N-1-i)*BW_OUT +: BW_OUT] =
                $signed(scalar) * $signed(vectorA_bus[(N-1-i)*BW +: BW]);
        end
    endgenerate
endmodule


// ============================================================
// VectorVector.v
// Multiplica vectorA(1xN) * vectorB(NxM) = vectorResultado(1xM)
// Orden de buses: MSB-first (el índice 0 está en bits más altos)
// ============================================================
module VectorVector #(
    parameter integer N       = 4,
    parameter integer M       = 4,
    parameter integer BW      = 16,
    parameter integer BW_OUT  = 32
)(
    input  wire signed [N*BW-1:0]       vectorA_bus,   // [A0..A(N-1)] (MSB→LSB)
    input  wire signed [N*M*BW-1:0]     vectorB_bus,   // [Fila0..Fila(N-1)] (MSB→LSB)
    output wire signed [M*BW_OUT-1:0]   result_bus     // [R0..R(M-1)] (MSB→LSB)
);

    wire signed [N*M*BW_OUT-1:0] temp_bus;

    // ========================================================
    // Multiplicación por filas: A[i] * B[i][:]
    // Cada resultado de VectorScalar se coloca también MSB-first
    // ========================================================
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : ROWS
            VectorScalar #(
                .N(M),
                .BW(BW),
                .BW_OUT(BW_OUT)
            ) scalar_mul_i (
                .scalar(vectorA_bus[(N-1-i)*BW +: BW]),                 // i=0 -> MSB
                .vectorA_bus(vectorB_bus[(N-1-i)*M*BW +: M*BW]),        // fila correspondiente (MSB-first)
                .result_bus(temp_bus[(N-1-i)*M*BW_OUT +: M*BW_OUT])     // salida MSB-first
            );
        end
    endgenerate


    // ========================================================
    // Suma por columnas (mantiene MSB-first)
    // ========================================================
    genvar j;
    generate
        for (j = 0; j < M; j = j + 1) begin : SUM_COLS
            integer k;
            reg signed [BW_OUT-1:0] col_sum;
            always @* begin
                col_sum = '0;
                for (k = 0; k < N; k = k + 1)
                    // Suma los elementos A[k]*B[k][j]
                    col_sum = col_sum + temp_bus[(N-1-k)*M*BW_OUT + (M-1-j)*BW_OUT +: BW_OUT];
            end
            assign result_bus[(M-1-j)*BW_OUT +: BW_OUT] = col_sum; // salida MSB-first
        end
    endgenerate

endmodule
