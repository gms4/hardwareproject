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
    reg divRun,fim;
    reg [31:0] resto,divisor;
    reg [31:0] dividendo,quociente;
    reg [5:0] digitoAtual;
    reg [5:0] c;

    assign hi=quociente;
	assign lo=resto;

    always @ (posedge clk) begin
		if (reset)begin
			resto=32'b0;
			divisor=32'b0;
			dividendo=32'b0;
			quociente=32'b0;
			digitoAtual=5'b0;
			c=5'b0;
			fim = 0;
			divRun = 0;
		end
    end
