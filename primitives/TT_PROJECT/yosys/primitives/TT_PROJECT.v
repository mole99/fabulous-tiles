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

(* blackbox, keep *)
module TT_PROJECT (
    input  UI_IN0,
    input  UI_IN1,
    input  UI_IN2,
    input  UI_IN3,
    input  UI_IN4,
    input  UI_IN5,
    input  UI_IN6,
    input  UI_IN7,

    output UO_OUT0,
    output UO_OUT1,
    output UO_OUT2,
    output UO_OUT3,
    output UO_OUT4,
    output UO_OUT5,
    output UO_OUT6,
    output UO_OUT7,

    input  UIO_IN0,
    input  UIO_IN1,
    input  UIO_IN2,
    input  UIO_IN3,
    input  UIO_IN4,
    input  UIO_IN5,
    input  UIO_IN6,
    input  UIO_IN7,

    output UIO_OUT0,
    output UIO_OUT1,
    output UIO_OUT2,
    output UIO_OUT3,
    output UIO_OUT4,
    output UIO_OUT5,
    output UIO_OUT6,
    output UIO_OUT7,
        
    output UIO_OE0,
    output UIO_OE1,
    output UIO_OE2,
    output UIO_OE3,
    output UIO_OE4,
    output UIO_OE5,
    output UIO_OE6,
    output UIO_OE7,
        
    input  ENA,
    (* clkbuf_sink *) input  CLK,
    input  RST_N
);

endmodule
