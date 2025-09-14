module Binary_to_BCD (
    bcd_data,
    binary
);

input      [9:0] binary;
output reg [9:0] bcd_data; // Note: For values > 399, this will need more bits. Assuming max score is 300.

always @(*) begin
    bcd_data[9:8] = binary / 100;          // get the hundreds
    bcd_data[7:4] = (binary / 10) % 10;    // get the tens
    bcd_data[3:0] = binary % 10;           // get the units
end

endmodule
