module score_keeping_tb();

reg  UPD, clk;
reg  [3:0] N;
wire Done;
wire [7:0] seven_data_hunds, seven_data_tens, seven_data_units;

// Instantiate the top module
score_keeping_top G1 (
    .seven_data_hunds(seven_data_hunds),
    .seven_data_tens(seven_data_tens),
    .seven_data_units(seven_data_units),
    .Done(Done),
    .N(N),
    .UPD(UPD),
    .clk(clk)
);

// Clock generation
initial begin
    clk = 1;
    forever #5 clk = ~clk;
end

// UPD signal generation
initial begin
    UPD = 0;
    forever #100 UPD = 1;
end

// Finish simulation when Done is high
always @(posedge Done) begin
    #100 $finish;
end

// --- Test Scenarios ---
// Please uncomment ONLY ONE of the following initial blocks to run a test.

/*
// Testbench 1: Perfect Game (滿分測試)
initial begin
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
end
*/

/*
// Testbench 2: No Bonus Frame (沒進BONUS)
initial begin
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=10;
    #100 N=8;
    #100 N=1;
end
*/

// Testbench 3: Mixed Spares, Strikes, and Open Frames (混合測試)
initial begin
    #100 N=8;    // Frame 1
    #100 N=2;    // Spare
    #100 N=10;   // Frame 2: Strike
    #100 N=7;    // Frame 3
    #100 N=1;
    #100 N=10;   // Frame 4: Strike
    #100 N=10;   // Frame 5: Strike
    #100 N=10;   // Frame 6: Strike
    #100 N=0;    // Frame 7
    #100 N=10;   // Spare
    #100 N=3;    // Frame 8
    #100 N=7;    // Spare
    #100 N=5;    // Frame 9
    #100 N=5;    // Spare
    #100 N=8;    // Frame 10
    #100 N=1;    // Bonus
end


endmodule
