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
module IHP_SRAM_1024x16_2RW #(
    parameter A_CLK_INV = 1'b0,
    parameter B_CLK_INV = 1'b0,
  )(
    (* clkbuf_sink *) input        A_CLK,
    input        A_ADDR0,
    input        A_ADDR1,
    input        A_ADDR2,
    input        A_ADDR3,
    input        A_ADDR4,
    input        A_ADDR5,
    input        A_ADDR6,
    input        A_ADDR7,
    input        A_ADDR8,
    input        A_ADDR9,
    input        A_DIN0,
    input        A_DIN1,
    input        A_DIN2,
    input        A_DIN3,
    input        A_DIN4,
    input        A_DIN5,
    input        A_DIN6,
    input        A_DIN7,
    input        A_DIN8,
    input        A_DIN9,
    input        A_DIN10,
    input        A_DIN11,
    input        A_DIN12,
    input        A_DIN13,
    input        A_DIN14,
    input        A_BM0,
    input        A_BM1,
    input        A_BM2,
    input        A_BM3,
    input        A_BM4,
    input        A_BM5,
    input        A_BM6,
    input        A_BM7,
    input        A_BM8,
    input        A_BM9,
    input        A_BM10,
    input        A_BM11,
    input        A_BM12,
    input        A_BM13,
    input        A_BM14,
    input        A_WEN,
    input        A_MEN,
    input        A_REN,
    output       A_DOUT0,
    output       A_DOUT1,
    output       A_DOUT2,
    output       A_DOUT3,
    output       A_DOUT4,
    output       A_DOUT5,
    output       A_DOUT6,
    output       A_DOUT7,
    output       A_DOUT8,
    output       A_DOUT9,
    output       A_DOUT10,
    output       A_DOUT11,
    output       A_DOUT12,
    output       A_DOUT13,
    output       A_DOUT14,

    (* clkbuf_sink *) input        B_CLK,
    input        B_ADDR0,
    input        B_ADDR1,
    input        B_ADDR2,
    input        B_ADDR3,
    input        B_ADDR4,
    input        B_ADDR5,
    input        B_ADDR6,
    input        B_ADDR7,
    input        B_ADDR8,
    input        B_ADDR9,
    input        B_DIN0,
    input        B_DIN1,
    input        B_DIN2,
    input        B_DIN3,
    input        B_DIN4,
    input        B_DIN5,
    input        B_DIN6,
    input        B_DIN7,
    input        B_DIN8,
    input        B_DIN9,
    input        B_DIN10,
    input        B_DIN11,
    input        B_DIN12,
    input        B_DIN13,
    input        B_DIN14,
    input        B_BM0,
    input        B_BM1,
    input        B_BM2,
    input        B_BM3,
    input        B_BM4,
    input        B_BM5,
    input        B_BM6,
    input        B_BM7,
    input        B_BM8,
    input        B_BM9,
    input        B_BM10,
    input        B_BM11,
    input        B_BM12,
    input        B_BM13,
    input        B_BM14,
    input        B_WEN,
    input        B_MEN,
    input        B_REN,
    output       B_DOUT0,
    output       B_DOUT1,
    output       B_DOUT2,
    output       B_DOUT3,
    output       B_DOUT4,
    output       B_DOUT5,
    output       B_DOUT6,
    output       B_DOUT7,
    output       B_DOUT8,
    output       B_DOUT9,
    output       B_DOUT10,
    output       B_DOUT11,
    output       B_DOUT12,
    output       B_DOUT13,
    output       B_DOUT14
);
    localparam WIDTH = 16;
    localparam DEPTH = 10;

    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [DEPTH-1:0] A_ADDR, B_ADDR;
    wire [WIDTH-1:0] A_DIN, B_DIN;
    wire [WIDTH-1:0] A_BM, B_DM;
    wire [WIDTH-1:0] A_DOUT, B_DOUT;
    
    assign A_ADDR = {A_ADDR9, A_ADDR8, A_ADDR7, A_ADDR6, A_ADDR5, A_ADDR4, A_ADDR3, A_ADDR2, A_ADDR1, A_ADDR0};
    assign A_DIN = {A_DIN14, A_DIN13, A_DIN12, A_DIN11, A_DIN10, A_DIN9, A_DIN8, A_DIN7, A_DIN6, A_DIN5, A_DIN4, A_DIN3, A_DIN2, A_DIN1, A_DIN0};
    assign A_BM = {A_BM14, A_BM13, A_BM12, A_BM11, A_BM10, A_BM9, A_BM8, A_BM7, A_BM6, A_BM5, A_BM4, A_BM3, A_BM2, A_BM1, A_BM0};

    assign {A_DOUT14, A_DOUT13, A_DOUT12, A_DOUT11, A_DOUT10, A_DOUT9, A_DOUT8, A_DOUT7, A_DOUT6, A_DOUT5, A_DOUT4, A_DOUT3, A_DOUT2, A_DOUT1, A_DOUT0} = A_DOUT;

    assign B_ADDR = {B_ADDR9, B_ADDR8, B_ADDR7, B_ADDR6, B_ADDR5, B_ADDR4, B_ADDR3, B_ADDR2, B_ADDR1, B_ADDR0};
    assign B_DIN = {B_DIN14, B_DIN13, B_DIN12, B_DIN11, B_DIN10, B_DIN9, B_DIN8, B_DIN7, B_DIN6, B_DIN5, B_DIN4, B_DIN3, B_DIN2, B_DIN1, B_DIN0};
    assign B_BM = {B_BM14, B_BM13, B_BM12, B_BM11, B_BM10, B_BM9, B_BM8, B_BM7, B_BM6, B_BM5, B_BM4, B_BM3, B_BM2, B_BM1, B_BM0};

    assign {B_DOUT14, B_DOUT13, B_DOUT12, B_DOUT11, B_DOUT10, B_DOUT9, B_DOUT8, B_DOUT7, B_DOUT6, B_DOUT5, B_DOUT4, B_DOUT3, B_DOUT2, B_DOUT1, B_DOUT0} = B_DOUT;

    // Clock inversion
    wire a_clk, b_clk;
    assign a_clk = A_CLK_INV ? !A_CLK : A_CLK;
    assign b_clk = B_CLK_INV ? !B_CLK : B_CLK;
    
    reg [WIDTH-1:0] mem [2**DEPTH];
    reg  [WIDTH-1:0] A_DOUT_reg, B_DOUT_reg;
    
    always @(posedge a_clk) begin
        if (A_MEN && A_WEN) begin
            mem[A_ADDR] <= (mem[A_ADDR] & ~A_BM) | (A_DIN & A_BM);
            if (A_REN) begin
                A_DOUT_reg <= (mem[A_ADDR] & ~A_BM) | (A_DIN & A_BM);
            end
        end else if (A_MEN && A_REN) begin
            A_DOUT_reg <= mem[A_ADDR];
        end
    end

    always @(posedge b_clk) begin
        if (B_MEN && B_WEN) begin
            mem[B_ADDR] <= (mem[B_ADDR] & ~B_BM) | (B_DIN & B_BM);
            if (B_REN) begin
                B_DOUT_reg <= (mem[B_ADDR] & ~B_BM) | (B_DIN & B_BM);
            end
        end else if (B_MEN && B_REN) begin
            B_DOUT_reg <= mem[B_ADDR];
        end
    end

    assign A_DOUT = A_DOUT_reg;
    assign B_DOUT = B_DOUT_reg;

endmodule
