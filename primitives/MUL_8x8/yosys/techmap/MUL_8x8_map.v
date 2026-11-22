// SPDX-FileCopyrightText: © 2026 FABulous Contributors
// SPDX-License-Identifier: Apache-2.0

module \$__FABULOUS_MUL (A, B, Y);
    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 0;
    parameter B_WIDTH = 0;
    parameter Y_WIDTH = 0;

    (* force_downto *)
    input [A_WIDTH-1:0] A;
    (* force_downto *)
    input [B_WIDTH-1:0] B;
    (* force_downto *)
    output [Y_WIDTH-1:0] Y;

    generate
    if (A_WIDTH > 8)
        wire _TECHMAP_FAIL_ = 1;
    else if (B_WIDTH > 8)
        wire _TECHMAP_FAIL_ = 1;
    else if (Y_WIDTH > 20)
        wire _TECHMAP_FAIL_ = 1;
    else if (A_SIGNED)
        wire _TECHMAP_FAIL_ = 1;
    else if (B_SIGNED)
        wire _TECHMAP_FAIL_ = 1;
    endgenerate

    wire [7:0] A_in, B_in;
    
    assign A_in = A;
    assign B_in = B;

    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [15:0] Y_out;

    assign Y = Y_out[Y_WIDTH-1:0];

    MACC_8x8_20 #(
        .A_REG    (1'b0),
        .B_REG    (1'b0),
        .Y_REG    (1'b0),
        .CLK_INV  (1'b0)
    ) _TECHMAP_REPLACE_ (
        .CLK  (),
        .EN   (1'b0),

        .A0 (A_in[0]),
        .A1 (A_in[1]),
        .A2 (A_in[2]),
        .A3 (A_in[3]),
        .A4 (A_in[4]),
        .A5 (A_in[5]),
        .A6 (A_in[6]),
        .A7 (A_in[7]),

        .B0 (B_in[0]),
        .B1 (B_in[1]),
        .B2 (B_in[2]),
        .B3 (B_in[3]),
        .B4 (B_in[4]),
        .B5 (B_in[5]),
        .B6 (B_in[6]),
        .B7 (B_in[7]),

        .Y0 (Y_out[0]),
        .Y1 (Y_out[1]),
        .Y2 (Y_out[2]),
        .Y3 (Y_out[3]),
        .Y4 (Y_out[4]),
        .Y5 (Y_out[5]),
        .Y6 (Y_out[6]),
        .Y7 (Y_out[7]),
        .Y8 (Y_out[8]),
        .Y9 (Y_out[9]),
        .Y10 (Y_out[10]),
        .Y11 (Y_out[11]),
        .Y12 (Y_out[12]),
        .Y13 (Y_out[13]),
        .Y14 (Y_out[14]),
        .Y15 (Y_out[15])
      );

endmodule
