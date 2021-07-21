module mux_ALU2 (

    input  wire [1:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    output wire [31:0] data_out

);

/*

data_0 --|
4 -------|--out1-------|\
data_2 --|               |--data_out--->
data_3 --|--out2-------|/

*/

wire [31:0] out1, out2;

assign out1 = (selector[0]) ? 32'd4 : data_0;
assign out2 = (selector[0]) ? data_2 : data_3;
assign data_out = (selector[1]) ? out1 : out2;


endmodule
