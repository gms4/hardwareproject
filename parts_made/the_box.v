module the_box (

    input wire [27:0] instr_input,
    input wire [31:0] pc_input,
    output wire [31:0] data_out

); 

    //concatenando
    assign data_out = {pc_input[31:28] , instr_input};

endmodule