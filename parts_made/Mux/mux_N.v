module mux_N(

    input  wire        selector,
    input  wire [31:0] data_0,
    input  wire [15:0] data_1,
    output wire [31:0] data_out

);

assign data_out = (selector) ? data_1[10:6] : data_0[4:0];

endmodule