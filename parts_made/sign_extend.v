module sign_extend (

    input  wire [15:0] data_in,
    output wire [31:0] data_out

);

     //se o bit de sinal for 1, extenderemos só com 1s, caso contrário, 0s
    assign data_out = (data_in[15]) ? {{16{1'b1}}, data_in} : {{16{1'b0}}, data_in};

endmodule