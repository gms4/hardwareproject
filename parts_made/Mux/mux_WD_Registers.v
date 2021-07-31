module mux_WD_Registers(

    input  wire [2:0] selector,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    input  wire [31:0] data_4,
    input  wire [31:0] data_5,
    input  wire [31:0] data_6,
    input  wire [31:0] data_7,
    output wire [31:0] data_out
);

/* 

227------| 
data_1---|--out1--\
data_2---|         |--out3-------\
data_3---|--out2--/               |                 
data_4---|                        |---data_out->
data_5---|--out4--|--\            |           
data_6---|        |   |--out6----/
data_7---|--out5--|--/

//000 ok

out1 = 227
out2 = data_2
out3 = out1 = 227
out4 = out3 = 227
out5 = out4 = 227
data_out = out5 = 227

//001 ok

out1 = data_1
out2 = data_3
out3 = data_1
out4 = data_1
out5 = data_1
data_out = data_1

//010 ok

out1 = 227
out2 = data_2
out3 = data_2
out4 = data_2
out5 = data_2
data_out = data_2

//011 ok

out1 = data_1
out2 = data_3
out3 = data_3
out4 = data_3
out5 = data_3
data_out = data_3

//100 ok

out1 = 227
out2 = data_2
out3 = 227
out4 = data_4
out5 = data_4
data_out = data_4

//101 ok

out1 = data_1
out2 = data_3
out3 = data_1
out4 = data_5
out5 = data_5
data_out = data_5

//110 ok

out1 = 227
out2 = data_2
out3 = data_2
out4 = data_4
out5 = data_6
data_out = data_6

*/

wire [31:0] out1, out2, out3, out4, out5, out6;

assign out1     = (selector[0]) ? data_1 : 32'd227;
assign out2     = (selector[0]) ? data_3 : data_2;
assign out3     = (selector[1]) ? out2   : out1;
assign out4     = (selector[0]) ? data_5 : data_4;
assign out5     = (selector[0]) ? data_7 : data_6;
assign out6     = (selector[1]) ? out5   : out4;
assign data_out = (selector[2]) ? out6   : out3;

/*
227------| 
data_1---|--out1--\
data_2---|         |--out3-------\
data_3---|--out2--/               |                 
data_4---|                        |---data_out->
data_5---|--out4--|--\            |           
data_6---|        |   |--out6----/
data_7---|--out5--|--/

*/

endmodule