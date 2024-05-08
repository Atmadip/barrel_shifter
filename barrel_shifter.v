`timescale 1ns / 1ps

module barrel_shifter #(parameter data_width = 8)
                       (input [data_width-1:0] data_in, 
                       input left_right_sel, 
                       input [2:0] bit_shift,
                       output [data_width-1:0] data_out);

wire [7:0] array_1;
wire [7:0] array_2;
wire [7:0] array_3;
wire [7:0] array_4;

//below generate block reverses the bits if left_right_sel is high.
genvar i;
generate
    for(i = 0; i<data_width; i=i+1) begin                      
        mux2_1 m0(data_in[i], data_in[data_width-1-i], left_right_sel, array_1[data_width-1-i]);
end
endgenerate

/*The code below shows how the above generate block would function, the code below is equivalent to 
what is writte in the generate block. It would create the required number of instances of mux in hardware when synthesized.

mux2_1 m0(data_in[7], data_in[0], left_right_sel, array_1[0]);
mux2_1 m1(data_in[6], data_in[1], left_right_sel, array_1[1]);
mux2_1 m2(data_in[5], data_in[2], left_right_sel, array_1[2]);
mux2_1 m3(data_in[4], data_in[3], left_right_sel, array_1[3]);
mux2_1 m4(data_in[3], data_in[4], left_right_sel, array_1[4]);
mux2_1 m5(data_in[2], data_in[5], left_right_sel, array_1[5]);
mux2_1 m6(data_in[1], data_in[6], left_right_sel, array_1[6]);
mux2_1 m7(data_in[0], data_in[7], left_right_sel, array_1[7]);
*/


//The below generate blocks shifts the data by 4 bits in the direction selected by the left_right_sel.
genvar j;
generate
    for(j=0; j<data_width/2; j=j+1) begin
        mux2_1 m1(1'b 0, array_1[data_width-1-j], bit_shift[2], array_2[data_width-1-j]);
        end
endgenerate

genvar k;
generate
    for(k=4; k<data_width; k=k+1) begin
        mux2_1 m2(array_1[data_width-1-k+4], array_1[data_width-1-k], bit_shift[2], array_2[data_width-1-k]);
        end
endgenerate


//The below generate blocks shifts the data by 2 bits in the direction selected by the left_right_sel.
mux2_1 m3(1'b 0, array_2[data_width-1], bit_shift[1], array_3[data_width-1]);
mux2_1 m4(1'b 0, array_2[data_width-1-1], bit_shift[1], array_3[data_width-1-1]);

genvar l;
generate
    for(l = 2; l<data_width; l=l+1) begin
        mux2_1 m5(array_2[data_width-1-l+2], array_2[data_width-1-l], bit_shift[1], array_3[data_width-1-l]);
        end
endgenerate


//The below generate blocks shifts the data by 1 bit in the direction selected by the left_right_sel.
mux2_1 m6(1'b 0, array_3[data_width-1], bit_shift[0], array_4[data_width-1]);

genvar m;
generate
    for(m = 1; m<data_width; m=m+1) begin
        mux2_1 m7(array_3[data_width-1-m+1], array_3[data_width-1-m], bit_shift[0], array_4[data_width-1-m]);
        end
endgenerate

//The generate bloxk below reverses the bits back to normal pattern if left_right_sel was used to reverse bits before.
genvar n;
generate
    for(n = 0; n<data_width; n=n+1) begin                      
        mux2_1 m0(array_4[n], array_4[data_width-1-n], left_right_sel, data_out[data_width-1-n]);
end
endgenerate

endmodule
