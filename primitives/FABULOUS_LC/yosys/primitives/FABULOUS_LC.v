// Copyright 2021 University of Manchester
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//	  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module LUTFF(input CLK, D, output reg O);
  initial O = 1'b0;
  always @ (posedge CLK) begin
    O <= D;
  end
endmodule

// TODO: carry chain
//       parameters
module FABULOUS_LC #(
  parameter K = 4,
  parameter [2**K-1:0] INIT = 0,
  parameter DFF_ENABLE = 1'b0
) (
  input CLK,
  input [K-1:0] I,
  output O,
  output Q
);
  wire f_wire;
  
  //LUT #(.K(K), .INIT(INIT)) lut_i(.I(I), .Q(f_wire));
  generate
    if (K == 1) begin
      LUT1 #(.INIT(INIT)) lut1 (.O(f_wire), .I0(I[0]));
    end else
    if (K == 2) begin
      LUT2 #(.INIT(INIT)) lut2 (.O(f_wire), .I0(I[0]), .I1(I[1]));
    end else
    if (K == 3) begin
      LUT3 #(.INIT(INIT)) lut3 (.O(f_wire), .I0(I[0]), .I1(I[1]), .I2(I[2]));
    end else
    if (K == 4) begin
      LUT4 #(.INIT(INIT)) lut4 (.O(f_wire), .I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]));
    end
  endgenerate
        
  LUTFF dff_i(.CLK(CLK), .D(f_wire), .Q(Q));

  assign O = f_wire;
endmodule
