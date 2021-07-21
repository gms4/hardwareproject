module mux_Extend(

    input  wire        selector,
    input  wire [15:0] data_0, //load size [15..0]
    input  wire [15:0] data_1, //instruction [15..0]
    output wire [15:0] data_out

);

assign data_out = (selector) ? data_1 : data_0;

endmodule