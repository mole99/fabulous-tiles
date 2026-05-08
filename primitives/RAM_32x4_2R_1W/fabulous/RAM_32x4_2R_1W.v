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
B_REG=0,
C_REG=1,
A_CLK_INV=2,
B_CLK_INV=3,
C_CLK_INV=4
*)
module RAM_32x4_2R_1W #(
    parameter NoConfigBits = 5,
    parameter WIDTH=4,
    parameter DEPTH=5
)(
    // Fabric side
    
    // Port A - Write
    input              A_CLK,
    input  [DEPTH-1:0] A_ADDR,
    input              A_WEN,
    input  [WIDTH-1:0] A_DIN,

    // Port B - Read
    input              B_CLK,
    input  [DEPTH-1:0] B_ADDR,
    input              B_REN,
    output [WIDTH-1:0] B_DOUT,

    // Port C - Read
    input              C_CLK,
    input  [DEPTH-1:0] C_ADDR,
    input              C_REN,
    output [WIDTH-1:0] C_DOUT,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Configuration bits
    wire B_REG, C_REG, A_CLK_INV, B_CLK_INV, C_CLK_INV;

    assign B_REG = ConfigBits[0];
    assign C_REG = ConfigBits[1];
    assign A_CLK_INV = ConfigBits[2];
    assign B_CLK_INV = ConfigBits[3];
    assign C_CLK_INV = ConfigBits[4];

    // Clock inversion
    wire a_clk, b_clk, c_clk;
    assign a_clk = A_CLK_INV ? !A_CLK : A_CLK;
    assign b_clk = B_CLK_INV ? !B_CLK : B_CLK;
    assign c_clk = C_CLK_INV ? !C_CLK : C_CLK;

    reg [WIDTH-1:0] mem [2**DEPTH];
    
    // Port A - Write
    always @(posedge a_clk) begin
        if (A_WEN) begin
            mem[A_ADDR] <= A_DIN;
        end
    end
    
    // Port B - Read
    wire [WIDTH-1:0] B_DOUT_comb;
    reg  [WIDTH-1:0] B_DOUT_reg;
    
    assign B_DOUT_comb = mem[B_ADDR];
    
    always @(posedge b_clk) begin
        if (B_REN) begin
            B_DOUT_reg <= B_DOUT_comb;
        end
    end
    
    assign B_DOUT = B_REG ? B_DOUT_reg : B_DOUT_comb;
    
    // Port C - Read
    wire [WIDTH-1:0] C_DOUT_comb;
    reg  [WIDTH-1:0] C_DOUT_reg;
    
    assign C_DOUT_comb = mem[C_ADDR];
    
    always @(posedge c_clk) begin
        if (C_REN) begin
            C_DOUT_reg <= C_DOUT_comb;
        end
    end
    
    assign C_DOUT = C_REG ? C_DOUT_reg : C_DOUT_comb;

endmodule
