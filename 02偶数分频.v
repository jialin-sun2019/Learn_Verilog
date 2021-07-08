
module Counts(rst_n,clk,out_clk);
	input rst_n,clk;
	output wire out_clk;
	
	parameter M = 10; //偶数分频    
	
	reg [3:0] cnts;
	reg c_out;
	
	always@(posedge clk) begin
		if(rst_n)
			cnts <= 4'b0;
		else if(cnts == (M/2)-1)  //分频数  -  1
			cnts <= 4'b0;
		else
			cnts <= cnts + 4'b1;
	end
	
	always@(posedge clk) begin
		if(rst_n)
			c_out <= 1'b0;
		else if(cnts == (M/2)-1) //
			c_out <= ~c_out;
	assign out_clk = c_out;
	end
endmodule
