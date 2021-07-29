module mult (
    input wire [31:0] value_A,
    input wire [31:0] value_B,
    input wire clk,
    input wire divInit,
    input wire divStop,
    input wire reset,
    output wire divZero,
    output wire [31:0] hi,
    output wire [31:0] lo
);
/*
 shift divisor right and compare it with current dividend 
 if divisor is larger, shift 0 as the next bit of the quotient 
 if divisor is smaller, subtract to get new dividend and shift 1 as the next bit of the quotient
*/	
    reg divRun,fim,stop,erroDivZero;
    reg [31:0] resto,divisor;
    reg [31:0] dividendo,quociente;
    reg [5:0] digitoAtual;
    reg [5:0] c;

    assign hi = resto;
	assign lo = quociente;

    assign divStop = stop;
    assign divZero = erroDivZero;
    always @ (posedge clk) begin
        if(divZero)begin
		    erroDivZero = 0;
	    end
        else if(divStop)begin
			stop = 0;
		end
		else if (reset)begin
			resto=32'b0;
			divisor=32'b0;
			dividendo=32'b0;
			quociente=32'b0;
			digitoAtual=5'b0;
			c=5'b0;
			fim = 0;
			divRun = 0;
            stop = 0;
		end
        else if(divInit)begin
            if(divRun)begin
                if(digitoAtual!=6'b111111)begin//-1
                    resto = {resto[30:0],dividendo[digitoAtual]};
                    if(resto>=divisor)begin
                        resto = resto - divisor;
                        quociente = {quociente[30:0],1'b1};  
                    end
                    else begin
                        quociente = {quociente[30:0],1'b0};
                    end
                    digitoAtual <= digitoAtual-1'b1;
                    c <= c+1'b1;
                end
                else begin
                    divRun=0;
                    fim=1;
                    stop = 1;
                end
            end
            else begin
                if(fim==0)begin
                    if(value_B==32'b0 )begin
			            erroDivZero = 1;
		            end
		            else begin
                        dividendo = value_A;
                        divisor  = value_B;
                        digitoAtual = 5'b11111;//31
                        divRun = 1;
                    end
                end
                else begin
                    fim = 0;
                end
            end
        end
    end
endmodule
