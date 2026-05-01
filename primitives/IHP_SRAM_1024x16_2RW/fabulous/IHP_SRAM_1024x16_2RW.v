// Copyright 2026 FABulous Contributors
// Copyright 2025 Leo Moser
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

module IHP_SRAM_1024x16_2RW (
    // Fabric side
    input                 A_CLK,
    input  [(10 - 1) : 0] A_ADDR,
    input  [(16 - 1) : 0] A_DIN,
    input  [(16 - 1) : 0] A_BM,
    input                 A_WEN,
    input                 A_MEN,
    input                 A_REN,
    	output [(16 - 1) : 0] A_DOUT,

    // Fabric side
    input                 B_CLK,
    input  [(10 - 1) : 0] B_ADDR,
    input  [(16 - 1) : 0] B_DIN,
    input  [(16 - 1) : 0] B_BM,
    input                 B_WEN,
    input                 B_MEN,
    input                 B_REN,
    	output [(16 - 1) : 0] B_DOUT,

    // External side
    (* FABulous, EXTERNAL *) output                A_CLK_SRAM,
    (* FABulous, EXTERNAL *) output [(10 - 1) : 0] A_ADDR_SRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] A_DIN_SRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] A_BM_SRAM,
    (* FABulous, EXTERNAL *) output                A_WEN_SRAM,
    (* FABulous, EXTERNAL *) output                A_MEN_SRAM,
    (* FABulous, EXTERNAL *) output                A_REN_SRAM,
    (* FABulous, EXTERNAL *) input  [(16 - 1) : 0] A_DOUT_SRAM,

    (* FABulous, EXTERNAL *) output                B_CLK_SRAM,
    (* FABulous, EXTERNAL *) output [(10 - 1) : 0] B_ADDR_SRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] B_DIN_SRAM,
    (* FABulous, EXTERNAL *) output [(16 - 1) : 0] B_BM_SRAM,
    (* FABulous, EXTERNAL *) output                B_WEN_SRAM,
    (* FABulous, EXTERNAL *) output                B_MEN_SRAM,
    (* FABulous, EXTERNAL *) output                B_REN_SRAM,
    (* FABulous, EXTERNAL *) input  [(16 - 1) : 0] B_DOUT_SRAM,

    (* FABulous, EXTERNAL *) output                TIE_HIGH_SRAM,
    (* FABulous, EXTERNAL *) output                TIE_LOW_SRAM,
    
    (* FABulous, EXTERNAL *) input                 CONFIGURED_top
);

    // Fabric -> External
    assign A_CLK_SRAM     = A_CLK;
    assign A_ADDR_SRAM    = A_ADDR;
    assign A_DIN_SRAM     = A_DIN;
    assign A_BM_SRAM      = A_BM;
    assign A_WEN_SRAM     = A_WEN;
    // Only enable the SRAM if the fabric is configured
    assign A_MEN_SRAM     = A_MEN && CONFIGURED_top;
    assign A_REN_SRAM     = A_REN;
    
    assign B_CLK_SRAM     = B_CLK;
    assign B_ADDR_SRAM    = B_ADDR;
    assign B_DIN_SRAM     = B_DIN;
    assign B_BM_SRAM      = B_BM;
    assign B_WEN_SRAM     = B_WEN;
    // Only enable the SRAM if the fabric is configured
    assign B_MEN_SRAM     = B_MEN && CONFIGURED_top;
    assign B_REN_SRAM     = B_REN;
    
    // External -> Fabric
    assign A_DOUT         = A_DOUT_SRAM;

    assign B_DOUT         = B_DOUT_SRAM;

    // Constants
    assign TIE_HIGH_SRAM = 1'b1;
    assign TIE_LOW_SRAM  = 1'b0;

endmodule
