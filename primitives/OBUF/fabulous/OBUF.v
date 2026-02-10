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
IN_REG=1
*)
module OBUF #(
    parameter NoConfigBits = 2
)(
    // Fabric side
    input  CLK,
    input  IN,
    input  EN,

    // External side
    (* FABulous, EXTERNAL *) output IN_top,
    (* FABulous, EXTERNAL *) output EN_top,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    logic EN_q, IN_q;

    always_ff @(posedge CLK) begin
        EN_q  <= EN;
        IN_q  <= IN;
    end

    // Fabric -> External
    assign IN_top = ConfigBits[1] ? IN_q : IN;
    assign EN_top = ConfigBits[0] ? EN_q : EN;

endmodule
