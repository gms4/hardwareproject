module mult (
    input wire [31:0] value_A,
    input wire [31:0] value_B,
    input wire clk,
    input wire divInit,
    input wire reset,
    output wire [31:0] hi,
    output wire [31:0] low
);
/*
 shift divisor right and compare it with current dividend 
 if divisor is larger, shift 0 as the next bit of the quotient 
 if divisor is smaller, subtract to get new dividend and shift 1 as the next bit of the quotient
*/	