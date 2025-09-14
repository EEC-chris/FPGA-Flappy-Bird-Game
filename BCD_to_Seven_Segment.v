module BCD_to_Seven_Segment (
    hunds_seven_segment_data,
    tens_seven_segment_data,
    units_seven_segment_data,
    bcd_data
);

input      [9:0] bcd_data;
output reg [7:0] hunds_seven_segment_data;
output reg [7:0] tens_seven_segment_data;
output reg [7:0] units_seven_segment_data;

parameter   BLANK = 8'b1111_1111, // Common Cathode, active-low
            ZERO  = 8'b1000_0001,
            ONE   = 8'b1100_1111,
            TWO   = 8'b1001_0010,
            THREE = 8'b1000_0110,
            FOUR  = 8'b1100_1100,
            FIVE  = 8'b1010_0100,
            SIX   = 8'b1010_0000,
            SEVEN = 8'b1000_1111,
            EIGHT = 8'b1000_0000,
            NINE  = 8'b1000_0100;

always @(*) begin
    // Hundreds digit
    case (bcd_data[9:8])
        2'd0: hunds_seven_segment_data = ZERO;
        2'd1: hunds_seven_segment_data = ONE;
        2'd2: hunds_seven_segment_data = TWO;
        2'd3: hunds_seven_segment_data = THREE;
        default: hunds_seven_segment_data = BLANK;
    endcase

    // Tens digit
    case (bcd_data[7:4])
        4'd0: tens_seven_segment_data = ZERO;
        4'd1: tens_seven_segment_data = ONE;
        4'd2: tens_seven_segment_data = TWO;
        4'd3: tens_seven_segment_data = THREE;
        4'd4: tens_seven_segment_data = FOUR;
        4'd5: tens_seven_segment_data = FIVE;
        4'd6: tens_seven_segment_data = SIX;
        4'd7: tens_seven_segment_data = SEVEN;
        4'd8: tens_seven_segment_data = EIGHT;
        4'd9: tens_seven_segment_data = NINE;
        default: tens_seven_segment_data = BLANK;
    endcase
    
    // Units digit
    case (bcd_data[3:0])
        4'd0: units_seven_segment_data = ZERO;
        4'd1: units_seven_segment_data = ONE;
        4'd2: units_seven_segment_data = TWO;
        4'd3: units_seven_segment_data = THREE;
        4'd4: units_seven_segment_data = FOUR;
        4'd5: units_seven_segment_data = FIVE;
        4'd6: units_seven_segment_data = SIX;
        4'd7: units_seven_segment_data = SEVEN;
        4'd8: units_seven_segment_data = EIGHT;
        4'd9: units_seven_segment_data = NINE;
        default: units_seven_segment_data = BLANK;
    endcase
end

endmodule
