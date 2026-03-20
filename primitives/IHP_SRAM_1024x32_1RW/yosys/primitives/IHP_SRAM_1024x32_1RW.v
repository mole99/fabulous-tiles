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
module IHP_SRAM_1024x32_1RW (
    input        CLK,
    input        ADDR0,
    input        ADDR1,
    input        ADDR2,
    input        ADDR3,
    input        ADDR4,
    input        ADDR5,
    input        ADDR6,
    input        ADDR7,
    input        ADDR8,
    input        ADDR9,
    input        DIN0,
    input        DIN1,
    input        DIN2,
    input        DIN3,
    input        DIN4,
    input        DIN5,
    input        DIN6,
    input        DIN7,
    input        DIN8,
    input        DIN9,
    input        DIN10,
    input        DIN11,
    input        DIN12,
    input        DIN13,
    input        DIN14,
    input        DIN15,
    input        DIN16,
    input        DIN17,
    input        DIN18,
    input        DIN19,
    input        DIN20,
    input        DIN21,
    input        DIN22,
    input        DIN23,
    input        DIN24,
    input        DIN25,
    input        DIN26,
    input        DIN27,
    input        DIN28,
    input        DIN29,
    input        DIN30,
    input        DIN31,
    input        BM0,
    input        BM1,
    input        BM2,
    input        BM3,
    input        BM4,
    input        BM5,
    input        BM6,
    input        BM7,
    input        BM8,
    input        BM9,
    input        BM10,
    input        BM11,
    input        BM12,
    input        BM13,
    input        BM14,
    input        BM15,
    input        BM16,
    input        BM17,
    input        BM18,
    input        BM19,
    input        BM20,
    input        BM21,
    input        BM22,
    input        BM23,
    input        BM24,
    input        BM25,
    input        BM26,
    input        BM27,
    input        BM28,
    input        BM29,
    input        BM30,
    input        BM31,
    input        WEN,
    input        MEN,
    input        REN,
    output       DOUT0,
    output       DOUT1,
    output       DOUT2,
    output       DOUT3,
    output       DOUT4,
    output       DOUT5,
    output       DOUT6,
    output       DOUT7,
    output       DOUT8,
    output       DOUT9,
    output       DOUT10,
    output       DOUT11,
    output       DOUT12,
    output       DOUT13,
    output       DOUT14,
    output       DOUT15,
    output       DOUT16,
    output       DOUT17,
    output       DOUT18,
    output       DOUT19,
    output       DOUT20,
    output       DOUT21,
    output       DOUT22,
    output       DOUT23,
    output       DOUT24,
    output       DOUT25,
    output       DOUT26,
    output       DOUT27,
    output       DOUT28,
    output       DOUT29,
    output       DOUT30,
    output       DOUT31
);
    localparam WIDTH = 32;
    localparam DEPTH = 10;

    // We need to combine individual bits into vectors
    // since FABulous doesn't support vectors for primitives yet
    wire [DEPTH-1:0] ADDR;
    wire [WIDTH-1:0] DIN;
    wire [WIDTH-1:0] BM;
    wire [WIDTH-1:0] DOUT;
    
    assign ADDR = {ADDR9, ADDR8, ADDR7, ADDR6, ADDR5, ADDR4, ADDR3, ADDR2, ADDR1, ADDR0};
    assign DIN = {DIN31, DIN30, DIN29, DIN28, DIN27, DIN26, DIN25, DIN24, DIN23, DIN22, DIN21, DIN20, DIN19, DIN18, DIN17, DIN16, DIN15, DIN14, DIN13, DIN12, DIN11, DIN10, DIN9, DIN8, DIN7, DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0};
    assign BM = {BM31, BM30, BM29, BM28, BM27, BM26, BM25, BM24, BM23, BM22, BM21, BM20, BM19, BM18, BM17, BM16, BM15, BM14, BM13, BM12, BM11, BM10, BM9, BM8, BM7, BM6, BM5, BM4, BM3, BM2, BM1, BM0};

    assign {DOUT31, DOUT30, DOUT29, DOUT28, DOUT27, DOUT26, DOUT25, DOUT24, DOUT23, DOUT22, DOUT21, DOUT20, DOUT19, DOUT18, DOUT17, DOUT16, DOUT15, DOUT14, DOUT13, DOUT12, DOUT11, DOUT10, DOUT9, DOUT8, DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0} = DOUT;

    reg [WIDTH-1:0] mem [2**DEPTH];
    reg  [WIDTH-1:0] DOUT_reg;
    
    always @(posedge CLK) begin
        if (MEN && WEN) begin
            mem[ADDR] <= DIN;
            if (REN) begin
                DOUT_reg <= DIN;
            end
        end else if (MEN && REN) begin
            DOUT_reg <= mem[ADDR];
        end
    end
    
    assign DOUT = DOUT_reg;

endmodule
