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

(* keep *)
module RAM_32x4_2R_1W #(
  parameter B_REG = 1'b0,
  parameter C_REG = 1'b0
  )(
    // Port A - Write
    input        A_CLK,
    input        A_ADDR0,
    input        A_ADDR1,
    input        A_ADDR2,
    input        A_ADDR3,
    input        A_ADDR4,
    input        A_WEN,
    input        A_DIN0,
    input        A_DIN1,
    input        A_DIN2,
    input        A_DIN3,

    // Port B - Read
    input        B_CLK,
    input        B_ADDR0,
    input        B_ADDR1,
    input        B_ADDR2,
    input        B_ADDR3,
    input        B_ADDR4,
    input        B_REN,
    output       B_DOUT0,
    output       B_DOUT1,
    output       B_DOUT2,
    output       B_DOUT3,

    // Port C - Read
    input        C_CLK,
    input        C_ADDR0,
    input        C_ADDR1,
    input        C_ADDR2,
    input        C_ADDR3,
    input        C_ADDR4,
    input        C_REN,
    output       C_DOUT0,
    output       C_DOUT1,
    output       C_DOUT2,
    output       C_DOUT3
);
    localparam WIDTH = 4;
    localparam DEPTH = 5;

    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [DEPTH-1:0] A_ADDR;
    wire [WIDTH-1:0] A_DIN;

    wire [DEPTH-1:0] B_ADDR;
    wire [WIDTH-1:0] B_DOUT;

    wire [DEPTH-1:0] C_ADDR;
    wire [WIDTH-1:0] C_DOUT;
    
    assign A_ADDR = {A_ADDR4, A_ADDR3, A_ADDR2, A_ADDR1, A_ADDR0};
    assign A_DIN = {A_DIN3, A_DIN2, A_DIN1, A_DIN0};

    assign B_ADDR = {B_ADDR4, B_ADDR3, B_ADDR2, B_ADDR1, B_ADDR0};
    assign B_DOUT0 = B_DOUT[0];
    assign B_DOUT1 = B_DOUT[0];
    assign B_DOUT2 = B_DOUT[0];
    assign B_DOUT3 = B_DOUT[0];

    assign C_ADDR = {C_ADDR4, C_ADDR3, C_ADDR2, C_ADDR1, C_ADDR0};
    assign C_DOUT0 = C_DOUT[0];
    assign C_DOUT1 = C_DOUT[0];
    assign C_DOUT2 = C_DOUT[0];
    assign C_DOUT3 = C_DOUT[0];

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
