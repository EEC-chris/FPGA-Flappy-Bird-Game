module score_keeping_top (
    seven_data_hunds,
    seven_data_tens,
    seven_data_units,
    Done,
    N,
    UPD,
    clk
);

output [7:0] seven_data_hunds, seven_data_tens, seven_data_units;
output       Done;
input  [3:0] N;
input        UPD, clk;

wire AD, NF, FT, APD, LF;

// Instantiate Controller
controller u_controller (
    .AD(AD),
    .NF(NF),
    .FT(FT),
    .Done(Done),
    .APD(APD),
    .LF(LF),
    .UPD(UPD),
    .clk(clk)
);

// Instantiate Datapath
datapath u_datapath (
    .seven_data_hunds(seven_data_hunds),
    .seven_data_tens(seven_data_tens),
    .seven_data_units(units_seven_segment_data),
    .APD(APD),
    .LF(LF),
    .N(N),
    .AD(AD),
    .NF(NF),
    .FT(FT),
    .clk(clk)
);

endmodule
