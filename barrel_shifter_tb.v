`timescale 1ns / 1ps

module barrel_shifter_tb#(parameter data_width = 8);

reg [data_width-1:0] data_in; 
reg left_right_sel;
reg [2:0] bit_shift;
wire [data_width-1:0] data_out;

barrel_shifter UUT(data_in, left_right_sel, bit_shift, data_out);

initial begin
#20;
data_in = 8'b 11110000;
left_right_sel = 1'b 0;
bit_shift = 3'b 000;
#20;

data_in = 8'b 11110000;
left_right_sel = 1'b 0;
bit_shift = 3'b 100;
#20;

data_in = 8'b 11110000;
left_right_sel = 1'b 1;
bit_shift = 3'b 001;
#20;
$finish;

end
endmodule
