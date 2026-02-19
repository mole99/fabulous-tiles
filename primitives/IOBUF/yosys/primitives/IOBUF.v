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
module IOBUF #(
  parameter EN_REG = 1'b0,
  parameter IN_REG = 1'b0,
  parameter OUT_REG = 1'b0
  )(
  input  CLK,
  input  EN,
  input  IN,
  output OUT,
  (* iopad_external_pin *) inout PAD
);

    reg EN_q, IN_q, PAD_q;

    always @(posedge CLK) begin
        EN_q  <= EN;
        IN_q  <= IN;
        PAD_q <= PAD;
    end

    wire EN_mux, IN_mux, PAD_mux;
    
    assign EN_mux = EN_REG ? EN_q : EN;
    assign IN_mux = IN_REG ? IN_q : IN;
    assign PAD_mux = OUT_REG ? PAD_q : PAD;

    assign PAD = EN_mux ? 1'bz : IN_mux;
    assign OUT = PAD_mux;

endmodule
