// Copyright 2026 FABulous Contributors
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

(* FABulous, BelMap,
A_REG=0,
B_REG=1,
C_REG=2,
MULTIPLY=3,
SIGN_EXT=4,
ACC_SEL=5,
ACC_OUT=6,
CLK_INV=7
*)
module MACC_8x8 #(
    parameter NoConfigBits = 8
)(
    // Fabric side
    input  CLK,
    input  EN,

    input  ACC_RST,
    input  ACC_CI,
    output ACC_CO,
    
    input  [ 7:0] A,
    input  [ 7:0] B,
    input  [19:0] C,
    
    output [19:0] Q,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Configuration bits
    wire A_REG, B_REG, C_REG, MULTIPLY, SIGN_EXT, ACC_SEL, ACC_OUT, CLK_INV;

    assign A_REG = ConfigBits[0];
    assign B_REG = ConfigBits[1];
    assign C_REG = ConfigBits[2];
    assign MULTIPLY = ConfigBits[3];
    assign SIGN_EXT = ConfigBits[4];
    assign ACC_SEL = ConfigBits[5];
    assign ACC_OUT = ConfigBits[6];
    assign CLK_INV = ConfigBits[7];

    // Clock inversion
    wire clk;
    assign clk = CLK_INV ? !CLK : CLK;

    // Registers the inputs
    logic [7:0] A_q, B_q;
    logic [19:0] C_q;

    always_ff @(posedge clk) begin
        if (EN) begin
            A_q <= A;
            B_q <= B;
            C_q <= C;
        end
    end
    
    // Select the operands
    logic [7:0] OPA, OPB;
    logic [19:0] OPC;
    
    assign OPA = A_REG ? A_q : A;
    assign OPB = B_REG ? B_q : B;
    assign OPC = C_REG ? C_q : C;
    
    // Multiplication
    wire [15:0] product;
    assign product = OPA * OPB;
    
    // Sign extension
    wire [15:0] to_extend;
    assign to_extend = MULTIPLY ? product : {OPB, OPA};
    
    wire [19:0] extended;
    assign extended = SIGN_EXT ? {{4{to_extend[15]}}, to_extend} : {4'd0, to_extend};

    // Addition
    wire [19:0] sum;

    // Accumulator
    logic [19:0] ACC;
    always_ff @(posedge clk) begin
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
