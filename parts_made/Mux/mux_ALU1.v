module mux_ALU1(

    input  wire [1:0] selector,
    input  wire [31:0] data_0,
    input  wire [31:0] data_1,
    output wire [31:0] data_out

);

/* 

  Data 0  - |
  Data 1  - |  out1 - - |
  0       - -    0  - - |- - - 
  
*/

wire [31:0] out1;

assign out1 = (selector[0]) ? data_1 : data_0;
assign data_out = (selector[1]) ? 32'd0 : out1;

endmodule