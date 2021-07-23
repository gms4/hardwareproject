module mux_WD_Registers(

    input  wire [2:0] selector,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    input  wire [31:0] data_4,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    output wire [31:0] data_out
);

/* 

227------| 
data_1---|--out1--\
data_2---|         |--out4------\
data_3---|--out2--/              |
data_4---|                       |--data_out-->
data_5---|--out3--|              |
data_6------------|--out5-------/

*/

wire [31:0] out1, out2, out3, out4, out5;

assign out1     = (selector[0]) ? data_1 : 32'd227;
assign out2     = (selector[0]) ? data_3 : data_2;
assign out3     = (selector[0]) ? data_5 : data_4;
assign out4     = (selector[1]) ? out2   : out1;
assign out5     = (selector[1]) ? data_6 : out3;
assign data_out = (selector[2]) ? out5   : out4;

endmodule