// Copyright 2026 University of Heidelberg
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

(* keep *)
module MACC_8x8_20 #(
    parameter A_REG = 1'b0,
    parameter B_REG = 1'b0,
    parameter C_REG = 1'b0,
    parameter SIGN_EXT = 1'b0,
    parameter ACC_SEL = 1'b0,
    parameter ACC_OUT = 1'b0,
    parameter CLK_INV = 1'b0
  )(
    input  CLK,
    input  EN,

    input  ACC_RST,
    input  ACC_CI,
    output ACC_CO,
    
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

    input  C0,
    input  C1,
    input  C2,
    input  C3,
    input  C4,
    input  C5,
    input  C6,
    input  C7,
    input  C8,
    input  C9,
    input  C10,
    input  C11,
    input  C12,
    input  C13,
    input  C14,
    input  C15,
    input  C16,
    input  C17,
    input  C18,
    input  C19,
    
    output Q0,
    output Q1,
    output Q2,
    output Q3,
    output Q4,
    output Q5,
    output Q6,
    output Q7,
    output Q8,
    output Q9,
    output Q10,
    output Q11,
    output Q12,
    output Q13,
    output Q14,
    output Q15,
    output Q16,
    output Q17,
    output Q18,
    output Q19
);
    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [ 7:0] A;
    wire [ 7:0] B;
    wire [19:0] C;
    wire [19:0] Q;
    
    assign A = {A7, A6, A5, A4, A3, A2, A1, A0};
    assign B = {B7, B6, B5, B4, B3, B2, B1, B0};
    assign C = {C19, C18, C17, C16, C15, C14, C13, C12, C11, C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0};

    assign {Q19, Q18, Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10, Q9, Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0} = Q;

    // Clock inversion
    wire clk;
    assign clk = CLK_INV ? !CLK : CLK;

    // Registers the inputs
    reg [7:0] A_q, B_q;
    reg [19:0] C_q;

    always @(posedge clk) begin
        if (EN) begin
            A_q <= A;
            B_q <= B;
            C_q <= C;
        end
    end
    
    // Select the operands
    wire [7:0] OPA, OPB;
    wire [19:0] OPC;
    
    assign OPA = A_REG ? A_q : A;
    assign OPB = B_REG ? B_q : B;
    assign OPC = C_REG ? C_q : C;
    
    // Multiplication
    wire [15:0] product;
    assign product = OPA * OPB;
    
    // Sign extension
    wire [19:0] extended;
    assign extended = SIGN_EXT ? {{4{product[15]}}, product} : {4'd0, product};

    // Addition
    wire [19:0] sum;

    // Accumulator
    reg [19:0] ACC;
    always @(posedge clk) begin
        if (ACC_RST) begin
            ACC <= '0;
        end else begin
            if (EN) begin
                ACC <= sum;
            end
        end
    end

    assign {ACC_CO, sum} = extended + (ACC_SEL ? ACC : OPC) + ACC_CI;

    // Output
    assign Q = ACC_OUT ? ACC : sum;

endmodule
