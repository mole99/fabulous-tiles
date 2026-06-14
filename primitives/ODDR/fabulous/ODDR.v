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
INIT_Q0=0,
INIT_Q1=1
*)
module ODDR #(
    parameter NoConfigBits = 2
)(
    // Fabric side
    input  CLK,
    input  D0,
    input  D1,
    input  EN,
    input  SR,
    output Q,

    // Static configuration bits
    (* FABulous, GLOBAL *) input [NoConfigBits-1:0] ConfigBits
);
    // Static configuration
    wire INIT_Q0, INIT_Q1;
    
    assign INIT_Q0 = ConfigBits[0];
    assign INIT_Q1 = ConfigBits[1];

    // Functionality
    logic D0_q, D1_q;

    always_ff @(posedge CLK) begin
        if (SR) begin
            D0_q <= INIT_Q0;
        end else begin
            if (EN) begin
                D0_q  <= D0;
            end
        end
    end
    
    always_ff @(negedge CLK) begin
        if (SR) begin
            D1_q <= INIT_Q1;
        end else begin
            if (EN) begin
                D1_q  <= D1;
            end
        end
    end
    
    assign Q = CLK ? D0_q : D1_q;

endmodule
