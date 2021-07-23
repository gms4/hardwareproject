module mux_A(

    input  wire [1:0]  selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    input  wire [31:0] data_2,
    output wire [31:0] data_out

);

/* 

  data_0  - |
  data_1  - |-- out1 --|
  data_2  -------------|-- data_out -->
  
*/


wire [31:0] out1;

assign out1 = (selector[0]) ? data_1 : data_0;
assign data_out = (selector[1]) ? data_2 : out1;

endmodule