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
EN_REG=0,
IN_REG=1,
OUT_REG=2
*)
module IOBUF #(
    parameter NoConfigBits = 3
)(
    // Fabric side
    input  CLK,
    input  IN,
    input  EN,
    output OUT,

    // External side
    (* FABulous, EXTERNAL *) output IN_top,
    (* FABulous, EXTERNAL *) output EN_top,
    (* FABulous, EXTERNAL *) input  OUT_top,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Static configuration
    wire EN_REG, IN_REG, OUT_REG;
    
    assign EN_REG = ConfigBits[0];
    assign IN_REG = ConfigBits[1];
    assign OUT_REG = ConfigBits[2];

    // Functionality
    logic EN_q, IN_q, OUT_top_q;

    always_ff @(posedge CLK) begin
        EN_q  <= EN;
        IN_q  <= IN;
        OUT_top_q <= OUT_top;
    end

    // Fabric -> External
    assign IN_top = IN_REG ? IN_q : IN;
    assign EN_top = EN_REG ? EN_q : EN;

    // External -> Fabric
    assign OUT = OUT_REG ? OUT_top_q : OUT_top;

endmodule
