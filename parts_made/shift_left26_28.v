module shift_left26_28 (

     input  wire [25:0] data_in,
     output wire [27:0] data_out

);
    
    wire [27:0] out1;

    assign out1     = {{2{1'd0}}, data_in};
    assign data_out = out1 << 2;

endmodule