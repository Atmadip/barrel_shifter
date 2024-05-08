`timescale 1ns / 1ps

module mux2_1(a_in, b_in, sel, d_out);

input a_in, b_in, sel;
output d_out;

assign d_out = (sel) ? a_in: b_in;
 
endmodule