module delay_time(clk,rst_n,in_data,out_data);
	input clk,rst_n,in_data;
	output out_data;
	
	reg [2:0] cnt_ctrl;//打两拍
	always@(posedge clk) begin
		cnt_ctrl <= {cnt_ctrl[1:0],in_data};
	end
	
	/* always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt_ctrl <= 3'b0;
		end
		else begin
			cnt_ctrl <= {cnt_ctrl[1:0],in_data};
		end
	end */
	
	assign out_data = cnt_ctrl[2];
endmodule 
