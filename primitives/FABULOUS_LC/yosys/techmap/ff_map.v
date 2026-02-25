module  \$_DFF_P_ (input D, C, output Q); LUTFF _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C)); endmodule

module  \$_DFFE_PP_ (input D, C, E, output Q); LUTFF_E  _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C), .E(E)); endmodule

module  \$_SDFF_PP0_ (input D, C, R, output Q); LUTFF_SR  _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C), .R(R)); endmodule
module  \$_SDFF_PP1_ (input D, C, R, output Q); LUTFF_SS  _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C), .S(R)); endmodule

module  \$_SDFFE_PP0P_ (input D, C, E, R, output Q); LUTFF_SRE  _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C), .E(E), .R(R)); endmodule
module  \$_SDFFE_PP1P_ (input D, C, E, R, output Q); LUTFF_SSE  _TECHMAP_REPLACE_ (.D(D), .O(Q), .CLK(C), .E(E), .S(R)); endmodule
