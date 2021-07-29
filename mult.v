module mult (
    input wire [31:0] value_A_Mc,
    input wire [31:0] value_B_Mp,
    input wire reset,
    input wire clk,
    input wire multInit,

    output [31:0] hi,
    output [31:0] low
);
    reg [64:0] AeQeQ_1,m,complemento_2;
	reg [5:0] c;
	reg [31:0]complemento_2_65_bits;
	reg stop,runMult,fim;
	
    assign multStop = stop;
    
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
      else if (multInit) begin
        if(multRun)begin
		if (c!=6'b100000) begin
        		case ({q[0], test})
        			2'b0_1 :begin//soma entre r e m
					sum=r+m;
					{r, q, test} <= {sum[31], sum, q};
			  	end
       				2'b1_0 : begin //subtracao
					diff = r-m;
					{r, q, test} <= {diff[31], diff, q};
		 	 	end	
        			default: {r, q, test} <= {r[31], r, q};//deslocamento
        		endcase
        		c <= c + 1'b1;
      		end
		else begin
			multRun=1'b0;
			fim = 1'b1;
		end
	end		
	else begin
		if(fim==0)begin
			m <=  value_A_Mc;
        		q <=  value_B_Mp;
			multRun<=1'b1;
		end
		else begin
			fim=0;
		end
	end
    end
end
endmodule