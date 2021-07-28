module mult (
    input wire [31:0] value_A_Mc,
    input wire [31:0] value_B_Mp,
    input wire reset,
    input wire clk,
    input wire multInit,

    output [31:0] hi,
    output [31:0] low
);

reg [31:0] m, q, r; 
reg [5:0] c;
reg test;
reg multRun,fim;
reg [31:0] sum, diff;

assign hi = {r, q};
assign low = c < 6'b100000;

    always @(posedge clk) begin
        if(reset)begin
            m<= 32'b0; 
            q<= 32'b0; 
            r<= 32'b0;
            c<=6'b0;
            test<=1'b0;
            multRun<=0;
            fim<=0;
        end
    end