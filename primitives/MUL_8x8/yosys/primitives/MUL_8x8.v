// SPDX-FileCopyrightText: © 2026 Leo Moser
// SPDX-License-Identifier: Apache-2.0

(* keep *)
module MUL_8x8_20 #(
    parameter A_REG = 1'b0,
    parameter B_REG = 1'b0,
    parameter Y_REG = 1'b0,
    parameter CLK_INV = 1'b0
  )(
    (* clkbuf_sink *) input  CLK,
    input  EN,
    
    input  A0,
    input  A1,
    input  A2,
    input  A3,
    input  A4,
    input  A5,
    input  A6,
    input  A7,

    input  B0,
    input  B1,
    input  B2,
    input  B3,
    input  B4,
    input  B5,
    input  B6,
    input  B7,
    
    output Y0,
    output Y1,
    output Y2,
    output Y3,
    output Y4,
    output Y5,
    output Y6,
    output Y7,
    output Y8,
    output Y9,
    output Y10,
    output Y11,
    output Y12,
    output Y13,
    output Y14,
    output Y15
);
    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [ 7:0] A;
    wire [ 7:0] B;
    wire [15:0] Y;
    
    assign A = {A7, A6, A5, A4, A3, A2, A1, A0};
    assign B = {B7, B6, B5, B4, B3, B2, B1, B0};

    assign {Y15, Y14, Y13, Y12, Y11, Y10, Y9, Y8, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = Y;

    // Clock inversion
    wire clk;
    assign clk = CLK_INV ? !CLK : CLK;

    // Registers the inputs
    reg [7:0] A_q, B_q;

    always @(posedge clk) begin
        if (EN) begin
            A_q <= A;
            B_q <= B;
        end
    end
    
    // Select the operands
    wire [7:0] OPA, OPB;
    
    assign OPA = A_REG ? A_q : A;
    assign OPB = B_REG ? B_q : B;
    
    // Multiplication
    wire [15:0] product;
    assign product = OPA * OPB;

    // Register the output
    reg [15:0] product_q;

    always @(posedge clk) begin
        if (EN) begin
            product_q <= product;
        end
    end

    // Output
    assign Y = Y_REG ? product_q : product;

endmodule
