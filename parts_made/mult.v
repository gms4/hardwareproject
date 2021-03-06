module mult(
    input wire [31:0] entradaA,
    input wire [31:0] entradaB,
    input wire clk,
    input wire reset,
    input wire multInit,

    output wire multStop,
    output reg [31:0] hi,
    output reg [31:0] lo
);
    reg [64:0] AeQeQ_1,m,complemento_2;
	reg [5:0] c;
	reg [31:0]complemento_2_65_bits;
	reg stop,runMult,fim;
	
    assign multStop = stop;
    always @(posedge clk) begin
		if(reset) begin
			AeQeQ_1 = 65'b0;
			m = 65'b0;
			complemento_2 = 65'b0;
			c = 6'b0;
			complemento_2_65_bits = 32'b0;
			runMult = 1'b0;
			fim = 1'b0;
			stop=0;
		end
    else begin
			if (multInit) begin
				if(runMult)begin
					if (c<6'b100000)begin
						if(AeQeQ_1[1]!=AeQeQ_1[0])begin
							if(AeQeQ_1[0]==0)begin //subracao por  isso usa temp pois ja e o complemento de 2
								AeQeQ_1=AeQeQ_1+ complemento_2;
							end
							else begin
								AeQeQ_1=AeQeQ_1+ m;
							end
						end
						AeQeQ_1=AeQeQ_1>>>1;
						if(AeQeQ_1[63]==1)begin
							AeQeQ_1[64]=1'b1;
						end
						c<=c+1;
					end
                    else begin
						hi = AeQeQ_1[64:33];
						lo = AeQeQ_1[32:1];
						runMult = 0;
						fim = 1;
						stop = 1;
					end
				end
				else begin
					if(fim==0)begin
						AeQeQ_1=AeQeQ_1+ m;
						AeQeQ_1<={32'b0,entradaB,1'b0};
						m = {entradaA[31:0], 33'b0};
						complemento_2_65_bits = ~entradaA + 32'b00000000000000000000000000000001;																			
						complemento_2 = {complemento_2_65_bits, 33'b0};
						c <= 6'b0;
						runMult=1'b1;
					end
					else begin
						fim=0;
					end
				end
			end
		end
	end
endmodule