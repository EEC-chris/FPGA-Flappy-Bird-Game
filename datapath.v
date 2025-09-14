module datapath (
    seven_data_hunds,
    seven_data_tens,
    seven_data_units,
    APD,
    LF,
    N,
    AD,
    NF,
    FT,
    clk
);

output [7:0] seven_data_hunds, seven_data_tens, seven_data_units;
output       APD; // All pins down
output       LF;  // Last frame
input  [3:0] N;
input        AD;  // Add score
input        NF;  // Next frame
input        FT;  // First throw
input        clk;

wire   [9:0] bcd_data, binary_data;

// Sub-module instantiations
APD_logic G1 (
    .APD(APD), 
    .N(N), 
    .FT(FT), 
    .clk(clk)
);

frame_counter G2 (
    .LF(LF), 
    .NF(NF)
);

score_register G3 (
    .binary_out(binary_data), 
    .AD(AD), 
    .N(N)
);

Binary_to_BCD G4 (
    .bcd_data(bcd_data), 
    .binary(binary_data)
);

BCD_to_Seven_Segment G5 (
    .hunds_seven_segment_data(seven_data_hunds), 
    .tens_seven_segment_data(seven_data_tens), 
    .units_seven_segment_data(units_seven_segment_data), 
    .bcd_data(bcd_data)
);

endmodule


//--- Sub-modules for Datapath ---

module APD_logic (
    APD,
    N,
    FT,
    clk
);
output reg APD;
input  [3:0] N;
input        FT;
input        clk;

reg [3:0] last_throw; // store how many pins were knocked down in the first throw

always @(posedge FT) begin // if it's the first throw, latch the pin count
    last_throw <= N;
end

always @(posedge clk) begin
    if (FT) begin
        if (N == 10) begin // Strike
            APD <= 1;
        end else begin
            APD <= 0;
        end
    end else begin // Second throw
        if (last_throw + N == 10) begin // Spare
            APD <= 1;
        end else begin
            APD <= 0;
        end
    end
end

endmodule


module score_register (
    binary_out,
    AD,
    N
);
output reg [9:0] binary_out;
input        AD;
input  [3:0] N;

initial binary_out = 0;

always @(posedge AD) begin
    binary_out <= binary_out + N;
end

endmodule


module frame_counter (
    LF,
    NF
);
output reg LF;
input        NF;

reg [3:0] counter_out;

initial begin
    counter_out = 1;
    LF = 0;
end

always @(posedge NF) begin
    counter_out <= counter_out + 1;
    if (counter_out == 10) begin
        LF <= 1; // if frame 10 is passed, set Last Frame flag
    end
end

endmodule
