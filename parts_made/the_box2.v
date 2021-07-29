module the_box2 (

    input wire  [4:0]  instr_input1,
    input wire  [4:0]  instr_input2,
    input wire  [15:0] instr_input3,
    output wire [25:0] data_out

); 

    //concatenando
    assign data_out = {instr_input1, instr_input2, instr_input3};


endmodule