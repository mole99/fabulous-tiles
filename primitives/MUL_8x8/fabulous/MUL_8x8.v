// Copyright 2026 Leo Moser
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
Y_REG=2,
CLK_INV=3
*)
module MUL_8x8 #(
    parameter NoConfigBits = 4
)(
    // Fabric side
    input  CLK,
    input  EN,
    
    input  [ 7:0] A,
    input  [ 7:0] B,
    
    output [15:0] Y,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Configuration bits
    wire A_REG, B_REG, Y_REG, CLK_INV;

    assign A_REG = ConfigBits[0];
    assign B_REG = ConfigBits[1];
    assign Y_REG = ConfigBits[2];
    assign CLK_INV = ConfigBits[3];

    // Clock inversion
    wire clk;
    assign clk = CLK_INV ? !CLK : CLK;

    // Register the inputs
    logic [7:0] A_q, B_q;

    always_ff @(posedge clk) begin
        if (EN) begin
            A_q <= A;
            B_q <= B;
        end
    end
    
    // Select the operands
    logic [7:0] OPA, OPB;
    
    assign OPA = A_REG ? A_q : A;
    assign OPB = B_REG ? B_q : B;
    
    // Multiplication
    wire [15:0] product;
    assign product = OPA * OPB;

    // Register the output
    logic [15:0] product_q;

    always_ff @(posedge clk) begin
        if (EN) begin
            product_q <= product;
        end
    end

    // Output
    assign Y = Y_REG ? product_q : product;

endmodule
