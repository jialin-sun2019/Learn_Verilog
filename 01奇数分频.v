
module Counts(rst_n,clk,out_clk);
	input rst_n,clk;
	output wire out_clk;
	
	parameter M = 5; //奇分频    
	
	reg [2:0] cnts_1,cnts_2;
	reg c_out1,c_out2;
	assign out_clk = c_out1 | c_out2;
	always@(posedge clk) begin
		if(rst_n)
			cnts_1 <= 3'b0;
		else if(cnts_1 == M-1)  //分频数  -  1
			cnts_1 <= 3'b0;
		else
			cnts_1 <= cnts_1 + 3'b1;
	end
	
	always@(posedge clk) begin
		if(rst_n)
			c_out1 <= 1'b0;
		else if(cnts_1 < (M-1)/2) //
			c_out1 <= 1'b1;
		else
			c_out1 <= 1'b0;
	end
	
	always@(negedge clk) begin
		if(rst_n)
			cnts_2 <= 3'b0;
		else if(cnts_2 == M-1)  //分频数  -  1
			cnts_2 <= 3'b0;
		else
			cnts_2 <= cnts_2 + 3'b1;
	end
	
	always@(negedge clk) begin
		if(rst_n)
			c_out2 <= 1'b0;
		else if(cnts_2 < (M-1)/2) //
			c_out2 <= 1'b1;
		else
			c_out2 <= 1'b0;
	end
endmodule
