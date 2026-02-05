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
OUT_REG=0
*)
module IBUF #(
    parameter NoConfigBits = 1
)(
    // Fabric side
    input  CLK,
    output OUT,

    // External side
    (* FABulous, EXTERNAL *) input  OUT_top,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    logic OUT_top_q;

    always_ff @(posedge CLK) begin
        OUT_top_q <= OUT_top;
    end

    // External -> Fabric
    assign OUT = ConfigBits[2] ? OUT_top_q : OUT_top;

endmodule
