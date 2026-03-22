module LUT1(output O, input I0);
  parameter [1:0] INIT = 0;
  assign O = I0 ? INIT[1] : INIT[0];
endmodule

module LUT2(output O, input I0, I1);
  parameter [3:0] INIT = 0;
  wire [ 1: 0] s1 = I1 ? INIT[ 3: 2] : INIT[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT3(output O, input I0, I1, I2);
  parameter [7:0] INIT = 0;
  wire [ 3: 0] s2 = I2 ? INIT[ 7: 4] : INIT[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT4(output O, input I0, I1, I2, I3);
  parameter [15:0] INIT = 0;
  wire [ 7: 0] s3 = I3 ? INIT[15: 8] : INIT[ 7: 0];
  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT4_HA(output O, Co, input I0, I1, I2, I3, Ci);
  parameter [15:0] INIT = 0;
  parameter I0MUX = 1'b1;

  wire [ 7: 0] s3 = I3 ? INIT[15: 8] : INIT[ 7: 0];
  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];

  wire I0_sel = I0MUX ? Ci : I0;
  assign O = I0_sel ? s1[1] : s1[0];

  assign Co = (Ci & I1) | (Ci & I2) | (I1 & I2);
endmodule

module LUT5(output O, input I0, I1, I2, I3, I4);
  parameter [31:0] INIT = 0;
  wire [15: 0] s4 = I4 ? INIT[31:16] : INIT[15: 0];
  wire [ 7: 0] s3 = I3 ?   s4[15: 8] :   s4[ 7: 0];
  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT6(output O, input I0, I1, I2, I3, I4, I5);
  parameter [63:0] INIT = 0;
  wire [31: 0] s5 = I5 ? INIT[63:32] : INIT[31: 0];
  wire [15: 0] s4 = I4 ?   s5[31:16] :   s5[15: 0];
  wire [ 7: 0] s3 = I3 ?   s4[15: 8] :   s4[ 7: 0];
  wire [ 3: 0] s2 = I2 ?   s3[ 7: 4] :   s3[ 3: 0];
  wire [ 1: 0] s1 = I1 ?   s2[ 3: 2] :   s2[ 1: 0];
  assign O = I0 ? s1[1] : s1[0];
endmodule

module LUT55_FCY (output O, Co, input I0, I1, I2, I3, I4, Ci);
  parameter [63:0] INIT = 0;

  wire comb1, comb2;

  LUT5 #(.INIT(INIT[31: 0])) l5_1 (.I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .O(comb1));
  LUT5 #(.INIT(INIT[63:32])) l5_2 (.I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .O(comb2));

  assign O = comb1 ^ Ci;
  assign Co = comb1 ? Ci : comb2;
endmodule

module LUTFF((* clkbuf_sink *) input CLK, input D, output reg O);
  initial O = 1'bx;
  always @ (posedge CLK) begin
    O <= D;
  end
endmodule

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

module LUTFF_E (
  output reg O,
  (* clkbuf_sink *) input CLK,
  input E, D
);
  initial O = 1'bx;
  always @(posedge CLK)
    if (E)
      O <= D;
endmodule

module LUTFF_SR (
  output reg O,
  (* clkbuf_sink *) input CLK,
  input R, D
);
  initial O = 1'bx;
  always @(posedge CLK)
    if (R)
      O <= 0;
    else
      O <= D;
endmodule

module LUTFF_SS (
  output reg O,
  (* clkbuf_sink *) input CLK,
  input S, D
);
  initial O = 1'bx;
  always @(posedge CLK)
    if (S)
      O <= 1;
    else
      O <= D;
endmodule

module LUTFF_SRE (
  output reg O,
  (* clkbuf_sink *) input CLK,
  input E, R, D
);
  initial O = 1'bx;
  always @(posedge CLK) begin
      if (R) begin
        O <= 0;
      end else begin
        if (E) begin
          O <= D;
        end
      end
  end
endmodule

module LUTFF_SSE (
  output reg O,
  (* clkbuf_sink *) input CLK,
  input E, S, D
);
  initial O = 1'bx;
  always @(posedge CLK) begin
      if (R) begin
        O <= 1;
      end else begin
        if (E) begin
          O <= D;
        end
      end
  end
endmodule
