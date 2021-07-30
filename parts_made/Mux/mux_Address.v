module mux_Address (

    input  wire [2:0]  selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    output wire [31:0] data_out

);

/*

data_0 --|
data_1 --|--out1--\
253 -----|         |--out3--\
254 -----|--out2--/          |--data_out-->
255 ------------------------/

000 = data_0 ok
001 = data_1 ok
010 = 253 ok
011 = 254 ok
100 = 255 ok

*/

wire [31:0] out1, out2, out3;

assign out1     = (selector[0]) ? data_1 : data_0;
assign out2     = (selector[0]) ? 32'd254 : 32'd253;
assign out3     = (selector[1]) ? out2 : out1;
assign data_out = (selector[2]) ? 32'd255 : out3;

endmodule