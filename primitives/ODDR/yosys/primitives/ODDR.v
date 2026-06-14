// Copyright 2026 University of Heidelberg
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
module ODDR #(
  parameter INIT_Q0 = 1'b0,
  parameter INIT_Q1 = 1'b0
  )(
  (* clkbuf_sink *) input  CLK,
  input  D0,
  input  D1,
  input  EN,
  input  SR,
  output Q
);

    reg D0_q, D1_q;

    always @(posedge CLK) begin
        if (SR) begin
            D0_q <= INIT_Q0;
        end else begin
            if (EN) begin
                D0_q  <= D0;
            end
        end
    end
    
    always @(negedge CLK) begin
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
