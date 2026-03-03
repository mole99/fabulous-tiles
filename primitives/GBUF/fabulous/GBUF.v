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

(*FABulous, BelMap,
    INVERT=0
*)
module GBUF #(
    // ConfigBits has to be adjusted manually (we don't use an arithmetic parser for the value)
    parameter N_CONFIG_BITS = 1
)(
    // Fabric side
    input  IN,
    output OUT,
    
    (* FABulous, GLOBAL *) input [N_CONFIG_BITS-1:0] ConfigBits // Config bits as vector
);

    wire INVERT;
  	  assign INVERT = ConfigBits[0];

    assign OUT = INVERT ? ~IN : IN;

endmodule
