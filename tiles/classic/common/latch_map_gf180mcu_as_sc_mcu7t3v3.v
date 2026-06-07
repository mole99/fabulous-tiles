// positive D-latch
module \$_DLATCH_P_ (input E, input D, output Q);
    gf180mcu_as_sc_mcu7t3v3__dlxfp_2 _TECHMAP_REPLACE_ (
        .ENA (E),
        .D  (D),
        .Q  (Q)
    );
endmodule

// negative D-latch
module \$_DLATCH_N_ (input E, input D, output Q);
    gf180mcu_as_sc_mcu7t3v3__dlxfn_2 _TECHMAP_REPLACE_ (
        .ENA (E),
        .D  (D),
        .Q  (Q)
    );
endmodule
