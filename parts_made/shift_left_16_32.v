module shift_left16_32 (

     input  wire [15:0] data_in,
     output wire [31:0] data_out

);

    assign data_out = data_in << 16;

endmodule