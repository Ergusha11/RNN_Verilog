// --- 0 ---
module W_h2o_r0 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w16, w17, w8, w25, w800;
  assign w1 = X;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w8 = w1 << 3;
  assign w25 = w17 + w8;
  assign w800 = w25 << 5;
  assign Y = w800[46:15];
endmodule

// --- 1 ---
module W_h2o_r1 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w2048, w2047, w2047_;
  assign w1 = X;
  assign w2048 = w1 << 11;
  assign w2047 = w2048 - w1;
  assign w2047_ = -1 * w2047;
  assign Y = w2047_[46:15];
endmodule

// --- 2 ---
module W_h2o_r2 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w64, w63, w1008, w945, w2, w943, w256, w687, w1374;
  assign w1 = X;
  assign w64 = w1 << 6;
  assign w63 = w64 - w1;
  assign w1008 = w63 << 4;
  assign w945 = w1008 - w63;
  assign w2 = w1 << 1;
  assign w943 = w945 - w2;
  assign w256 = w1 << 8;
  assign w687 = w943 - w256;
  assign w1374 = w687 << 1;
  assign Y = w1374[46:15];
endmodule

// --- 3 ---
module W_h2o_r3 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w16, w17, w136, w153, w2448;
  assign w1 = X;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w136 = w17 << 3;
  assign w153 = w17 + w136;
  assign w2448 = w153 << 4;
  assign Y = w2448[46:15];
endmodule

// --- 4 ---
module W_h2o_r4 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w64, w63, w16, w79, w632, w633, w2532, w2532_;
  assign w1 = X;
  assign w64 = w1 << 6;
  assign w63 = w64 - w1;
  assign w16 = w1 << 4;
  assign w79 = w63 + w16;
  assign w632 = w79 << 3;
  assign w633 = w1 + w632;
  assign w2532 = w633 << 2;
  assign w2532_ = -1 * w2532;
  assign Y = w2532_[46:15];
endmodule

// --- 5 ---
module W_h2o_r5 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w64, w63, w2048, w1985, w3970, w3970_;
  assign w1 = X;
  assign w64 = w1 << 6;
  assign w63 = w64 - w1;
  assign w2048 = w1 << 11;
  assign w1985 = w2048 - w63;
  assign w3970 = w1985 << 1;
  assign w3970_ = -1 * w3970;
  assign Y = w3970_[46:15];
endmodule

// --- 6 ---
module W_h2o_r6 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w512, w513, w2048, w1535, w16, w1519, w128, w1391, w2782, w2782_;
  assign w1 = X;
  assign w512 = w1 << 9;
  assign w513 = w1 + w512;
  assign w2048 = w1 << 11;
  assign w1535 = w2048 - w513;
  assign w16 = w1 << 4;
  assign w1519 = w1535 - w16;
  assign w128 = w1 << 7;
  assign w1391 = w1519 - w128;
  assign w2782 = w1391 << 1;
  assign w2782_ = -1 * w2782;
  assign Y = w2782_[46:15];
endmodule

// --- 7 ---
module W_h2o_r7 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w4096, w4095, w1024, w5119, w8, w7, w56, w5063;
  assign w1 = X;
  assign w4096 = w1 << 12;
  assign w4095 = w4096 - w1;
  assign w1024 = w1 << 10;
  assign w5119 = w4095 + w1024;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w56 = w7 << 3;
  assign w5063 = w5119 - w56;
  assign Y = w5063[46:15];
endmodule

// --- 8 ---
module W_h2o_r8 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w8, w7, w7168, w7161, w128, w7033, w7033_;
  assign w1 = X;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w7168 = w7 << 10;
  assign w7161 = w7168 - w7;
  assign w128 = w1 << 7;
  assign w7033 = w7161 - w128;
  assign w7033_ = -1 * w7033;
  assign Y = w7033_[46:15];
endmodule

// --- 9 ---
module W_h2o_r9 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w1024, w1023, w128, w127, w508, w1531, w6124;
  assign w1 = X;
  assign w1024 = w1 << 10;
  assign w1023 = w1024 - w1;
  assign w128 = w1 << 7;
  assign w127 = w128 - w1;
  assign w508 = w127 << 2;
  assign w1531 = w1023 + w508;
  assign w6124 = w1531 << 2;
  assign Y = w6124[46:15];
endmodule

// --- 10 ---
module W_h2o_r10 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w256, w255, w32, w287, w1148, w1435, w1435_;
  assign w1 = X;
  assign w256 = w1 << 8;
  assign w255 = w256 - w1;
  assign w32 = w1 << 5;
  assign w287 = w255 + w32;
  assign w1148 = w287 << 2;
  assign w1435 = w287 + w1148;
  assign w1435_ = -1 * w1435;
  assign Y = w1435_[46:15];
endmodule

// --- 11 ---
module W_h2o_r11 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w8, w7, w112, w113, w3616, w3729;
  assign w1 = X;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w112 = w7 << 4;
  assign w113 = w1 + w112;
  assign w3616 = w113 << 5;
  assign w3729 = w113 + w3616;
  assign Y = w3729[46:15];
endmodule

// --- 12 ---
module W_h2o_r12 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w4, w5, w80, w75, w4800, w4799, w4799_;
  assign w1 = X;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign w80 = w5 << 4;
  assign w75 = w80 - w5;
  assign w4800 = w75 << 6;
  assign w4799 = w4800 - w1;
  assign w4799_ = -1 * w4799;
  assign Y = w4799_[46:15];
endmodule

// --- 13 ---
module W_h2o_r13 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w256, w255, w2040, w1785, w7140, w7139, w16, w7123;
  assign w1 = X;
  assign w256 = w1 << 8;
  assign w255 = w256 - w1;
  assign w2040 = w255 << 3;
  assign w1785 = w2040 - w255;
  assign w7140 = w1785 << 2;
  assign w7139 = w7140 - w1;
  assign w16 = w1 << 4;
  assign w7123 = w7139 - w16;
  assign Y = w7123[46:15];
endmodule

// --- 14 ---
module W_h2o_r14 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w2048, w2047, w64, w2111, w4, w2107, w256, w1851;
  assign w1 = X;
  assign w2048 = w1 << 11;
  assign w2047 = w2048 - w1;
  assign w64 = w1 << 6;
  assign w2111 = w2047 + w64;
  assign w4 = w1 << 2;
  assign w2107 = w2111 - w4;
  assign w256 = w1 << 8;
  assign w1851 = w2107 - w256;
  assign Y = w1851[46:15];
endmodule

// --- 15 ---
module W_h2o_r15 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w256, w257, w4096, w4095, w16, w273, w1092, w5187, w5187_;
  assign w1 = X;
  assign w256 = w1 << 8;
  assign w257 = w1 + w256;
  assign w4096 = w1 << 12;
  assign w4095 = w4096 - w1;
  assign w16 = w1 << 4;
  assign w273 = w257 + w16;
  assign w1092 = w273 << 2;
  assign w5187 = w4095 + w1092;
  assign w5187_ = -1 * w5187;
  assign Y = w5187_[46:15];
endmodule

// --- 16 ---
module W_h2o_r16 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w8192, w8191, w256, w8447, w16, w8431, w4, w8427;
  assign w1 = X;
  assign w8192 = w1 << 13;
  assign w8191 = w8192 - w1;
  assign w256 = w1 << 8;
  assign w8447 = w8191 + w256;
  assign w16 = w1 << 4;
  assign w8431 = w8447 - w16;
  assign w4 = w1 << 2;
  assign w8427 = w8431 - w4;
  assign Y = w8427[46:15];
endmodule

// --- 17 ---
module W_h2o_r17 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w128, w127, w8, w119, w16, w103, w6592, w6695, w6695_;
  assign w1 = X;
  assign w128 = w1 << 7;
  assign w127 = w128 - w1;
  assign w8 = w1 << 3;
  assign w119 = w127 - w8;
  assign w16 = w1 << 4;
  assign w103 = w119 - w16;
  assign w6592 = w103 << 6;
  assign w6695 = w103 + w6592;
  assign w6695_ = -1 * w6695;
  assign Y = w6695_[46:15];
endmodule

// --- 18 ---
module W_h2o_r18 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w16, w17, w8, w25, w4352, w4377, w4377_;
  assign w1 = X;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w8 = w1 << 3;
  assign w25 = w17 + w8;
  assign w4352 = w17 << 8;
  assign w4377 = w25 + w4352;
  assign w4377_ = -1 * w4377;
  assign Y = w4377_[46:15];
endmodule

// --- 19 ---
module W_h2o_r19 (X, Y);
  input  signed [31:0] X;
  output signed [31:0] Y;
  wire signed [46:0] w1, w16, w15, w1024, w1039, w120, w919, w1838, w1838_;
  assign w1 = X;
  assign w16 = w1 << 4;
  assign w15 = w16 - w1;
  assign w1024 = w1 << 10;
  assign w1039 = w15 + w1024;
  assign w120 = w15 << 3;
  assign w919 = w1039 - w120;
  assign w1838 = w919 << 1;
  assign w1838_ = -1 * w1838;
  assign Y = w1838_[46:15];
endmodule