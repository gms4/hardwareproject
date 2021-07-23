module mux_PC(

    input  wire [1:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    input  wire [31:0] data_3,
    output wire [31:0] data_out




);

/*
data_0---|
data_1---|--out1--|
data_2---|--out2--|--data_out-->
data_3---|

*/

wire [31:0] out1, out2;

assign out1     = (selector[0]) ? data_1 : data_0;
assign out2     = (selector[0]) ? data_3 : data_2;
assign data_out = (selector[1]) ? out2 : out1;

endmodule