module mux_WR_Registers(

    input  wire [1:0]  selector,
    input  wire [4:0] data_0, //instruction [20..16]
    input  wire [15:0] data_3, //instruction [15..11]
    output wire [4:0] data_out 

);


/* 

data_0 ---|
29 -------|--out1--\
31 -------|         |--data_out-->
data_3 ---|--out2--/

//00

out1 = data_0
out2 = 31
data_out = data_0

//01

out1 = 29
out2 = data_3
data_out = 29

//10

out1 = data_0
out2 = 31
data_out = out2 = 31

/11

out1 = 29
out2 = data_3
data_out = data_3

*/

wire [31:0] out1, out2;
//00 data 0 ok
//01 29 ok
//10 31 ok
//11 data3 ok

assign out1     = (selector[0]) ? 5'd29 : data_0;
assign out2     = (selector[0]) ? data_3[15:11] : 5'd31;
assign data_out = (selector[1]) ? out2 : out1;

endmodule