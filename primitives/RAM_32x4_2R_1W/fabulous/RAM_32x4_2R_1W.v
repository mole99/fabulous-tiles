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
C_REG=1
*)
module RAM_32x4_2R_1W #(
    parameter NoConfigBits = 2,
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
    reg [WIDTH-1:0] mem [2**DEPTH];
    
    // Port A - Write
    always @(posedge A_CLK) begin
        if (A_WEN) begin
            mem[A_ADDR] <= A_DIN;
        end
    end
    
    // Port B - Read
    wire [WIDTH-1:0] B_DOUT_comb;
    reg  [WIDTH-1:0] B_DOUT_reg;
    
    assign B_DOUT_comb = mem[B_ADDR];
    
    always @(posedge B_CLK) begin
        if (B_REN) begin
            B_DOUT_reg <= B_DOUT_comb;
        end
    end
    
    assign B_DOUT = ConfigBits[0] ? B_DOUT_reg : B_DOUT_comb;
    
    // Port C - Read
    wire [WIDTH-1:0] C_DOUT_comb;
    reg  [WIDTH-1:0] C_DOUT_reg;
    
    assign C_DOUT_comb = mem[C_ADDR];
    
    always @(posedge C_CLK) begin
        if (C_REN) begin
            C_DOUT_reg <= C_DOUT_comb;
        end
    end
    
    assign C_DOUT = ConfigBits[1] ? C_DOUT_reg : C_DOUT_comb;

endmodule
