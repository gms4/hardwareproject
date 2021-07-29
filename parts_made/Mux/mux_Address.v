module mux_Address (

    input  wire [2:0]  selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    output wire [31:0] data_out

);

/*

data_0 --|
data_1 --|--out1-----------\
253 -----|                  |
254 -----|--out2--|         |--data_out-->
255 --------------|--out3--/

*/

wire [31:0] out1, out2, out3;

assign out1     = (selector[0]) ? data_1 : data_0;
assign out2     = (selector[0]) ? 32'd254 : 32'd253;
assign out3     = (selector[1]) ? 32'd255 : out2;
assign data_out = (selector[2]) ? out3 : out1;

endmodule