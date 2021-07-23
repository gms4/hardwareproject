module sign_extend1_32(

    input  wire        data_in,
    output wire [31:0] data_out

);

     //se o bit de sinal for 1, extenderemos só com 1s, caso contrário, 0s
    assign data_out = data_in ? {{32{1'b1}}, data_in} : {{32{1'b0}}, data_in};

endmodule