module mult (
    input wire [31:0] value_A_Mc,
    input wire [31:0] value_B_Mp,
    input wire reset,
    input wire clk,
    input wire multInit,

    output [31:0] hi,
    output [31:0] low
);