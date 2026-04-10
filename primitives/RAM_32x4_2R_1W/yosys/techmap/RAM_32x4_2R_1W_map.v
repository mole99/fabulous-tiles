(* techmap_celltype = "$__RAM_32x4_2R_1W_[AS][AS]_" *)
module \$__RAM_32x4_2R_1W_XX_ (...);

    parameter _TECHMAP_CELLTYPE_ = "";

    // note: string is indexed from right to left
    localparam [0:0] C_SYNC = _TECHMAP_CELLTYPE_[15:8] == "S";
    localparam [0:0] B_SYNC = _TECHMAP_CELLTYPE_[23:16] == "S";

    localparam WIDTH = 4;
    localparam ABITS = 5;

    input [WIDTH-1:0] PORT_A_WR_DATA;
    input [ABITS-1:0] PORT_A_ADDR;
    input PORT_A_WR_EN;

    output [WIDTH-1:0] PORT_B_RD_DATA;
    input [ABITS-1:0] PORT_B_ADDR;
    input PORT_B_RD_EN;

    output [WIDTH-1:0] PORT_C_RD_DATA;
    input [ABITS-1:0] PORT_C_ADDR;
    input PORT_C_RD_EN;

    input PORT_A_CLK;
    input PORT_B_CLK;
    input PORT_C_CLK;

    RAM_32x4_2R_1W #(
      .B_REG (B_SYNC),
      .C_REG (C_SYNC)
    ) _TECHMAP_REPLACE_ (
        // Port A - Write
        .A_CLK    (PORT_A_CLK),
        .A_ADDR0  (PORT_A_ADDR[0]),
        .A_ADDR1  (PORT_A_ADDR[1]),
        .A_ADDR2  (PORT_A_ADDR[2]),
        .A_ADDR3  (PORT_A_ADDR[3]),
        .A_ADDR4  (PORT_A_ADDR[4]),
        .A_WEN    (PORT_A_WR_EN),
        .A_DIN0   (PORT_A_WR_DATA[0]),
        .A_DIN1   (PORT_A_WR_DATA[1]),
        .A_DIN2   (PORT_A_WR_DATA[2]),
        .A_DIN3   (PORT_A_WR_DATA[3]),

        // Port B - Read
        .B_CLK    (PORT_B_CLK),
        .B_ADDR0  (PORT_B_ADDR[0]),
        .B_ADDR1  (PORT_B_ADDR[1]),
        .B_ADDR2  (PORT_B_ADDR[2]),
        .B_ADDR3  (PORT_B_ADDR[3]),
        .B_ADDR4  (PORT_B_ADDR[4]),
        .B_REN    (PORT_B_RD_EN),
        .B_DOUT0  (PORT_B_RD_DATA[0]),
        .B_DOUT1  (PORT_B_RD_DATA[1]),
        .B_DOUT2  (PORT_B_RD_DATA[2]),
        .B_DOUT3  (PORT_B_RD_DATA[3]),

        // Port C - Read
        .C_CLK    (PORT_C_CLK),
        .C_ADDR0  (PORT_C_ADDR[0]),
        .C_ADDR1  (PORT_C_ADDR[1]),
        .C_ADDR2  (PORT_C_ADDR[2]),
        .C_ADDR3  (PORT_C_ADDR[3]),
        .C_ADDR4  (PORT_C_ADDR[4]),
        .C_REN    (PORT_C_RD_EN),
        .C_DOUT0  (PORT_C_RD_DATA[0]),
        .C_DOUT1  (PORT_C_RD_DATA[1]),
        .C_DOUT2  (PORT_C_RD_DATA[2]),
        .C_DOUT3  (PORT_C_RD_DATA[3])
    );

endmodule
