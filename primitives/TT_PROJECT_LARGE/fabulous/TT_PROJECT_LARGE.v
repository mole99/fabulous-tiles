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

(*FABulous, BelMap,
    ENABLE_POWER=0
*)
module TT_PROJECT_LARGE #(
    parameter N_CONFIG_BITS = 1
)(	
    // Fabric side
    input  wire [15:0] UI_IN,
    output wire [15:0] UO_OUT,
    input  wire [15:0] UIO_IN,
    output wire [15:0] UIO_OUT,
    output wire [15:0] UIO_OE,
    input  wire       ENA,
    input  wire       CLK,
    input  wire       RST_N,

    // External side
    (* FABulous, EXTERNAL *) output wire        ENABLE_POWER_TT_PROJECT,
    (* FABulous, EXTERNAL *) output wire [15:0] UI_IN_TT_PROJECT,
    (* FABulous, EXTERNAL *) input  wire [15:0] UO_OUT_TT_PROJECT,
    (* FABulous, EXTERNAL *) output wire [15:0] UIO_IN_TT_PROJECT,
    (* FABulous, EXTERNAL *) input  wire [15:0] UIO_OUT_TT_PROJECT,
    (* FABulous, EXTERNAL *) input  wire [15:0] UIO_OE_TT_PROJECT,
    (* FABulous, EXTERNAL *) output wire        ENA_TT_PROJECT,
    (* FABulous, EXTERNAL *) output wire        CLK_TT_PROJECT,
    (* FABulous, EXTERNAL *) output wire        RST_N_TT_PROJECT,
    
    (* FABulous, GLOBAL *) input [N_CONFIG_BITS-1:0] ConfigBits // Config bits as vector
);
    // Configuration bits
    wire ENABLE_POWER;
	  assign ENABLE_POWER = ConfigBits[0];

    // Fabric -> External
    assign ENABLE_POWER_TT_PROJECT = ENABLE_POWER;
    assign CLK_TT_PROJECT       = CLK;
    assign UI_IN_TT_PROJECT     = UI_IN;
    assign UIO_IN_TT_PROJECT    = UIO_IN;
    assign ENA_TT_PROJECT       = ENA;
    assign RST_N_TT_PROJECT     = RST_N;
    
    // External -> Fabric
    assign UO_OUT   = UO_OUT_TT_PROJECT;
    assign UIO_OUT  = UIO_OUT_TT_PROJECT;
    assign UIO_OE   = UIO_OE_TT_PROJECT;

endmodule
