module \$__FABULOUS_IBUF (input PAD, output OUT);
	IOBUF _TECHMAP_REPLACE_ (.PAD(PAD), .OUT(OUT), .EN(1'b0));
endmodule

module \$__FABULOUS_OBUF (output PAD, input IN);
	IOBUF _TECHMAP_REPLACE_ (.PAD(PAD), .IN(IN), .EN(1'b1));
endmodule

module \$__FABULOUS_TBUF (output PAD, input IN, input EN);
	IOBUF _TECHMAP_REPLACE_ (.PAD(PAD), .IN(IN), .EN(EN));
endmodule

module \$__FABULOUS_IOBUF (inout PAD, output OUT, input IN, input EN);
	IOBUF _TECHMAP_REPLACE_ (.PAD(PAD), .OUT(OUT), .IN(IN), .EN(EN));
endmodule


/*
module \$__FABULOUS_IBUF (input PAD, output OUT);
	IBUF _TECHMAP_REPLACE_ (.PAD(PAD), .OUT(OUT));
endmodule

module \$__FABULOUS_OBUF (output PAD, input IN);
	OBUF _TECHMAP_REPLACE_ (.PAD(PAD), .IN(IN));
endmodule

module \$__FABULOUS_TBUF (output PAD, input IN, input EN);
	TBUF _TECHMAP_REPLACE_ (.PAD(PAD), .IN(IN), .EN(EN));
endmodule

module \$__FABULOUS_IOBUF (inout PAD, output OUT, input IN, input EN);
	IOBUF _TECHMAP_REPLACE_ (.PAD(PAD), .OUT(OUT), .IN(IN), .EN(EN));
endmodule
*/
