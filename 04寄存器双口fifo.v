
module DUAL_FIFO(clk,rst_n,in_data,out_data,
				fifo_empty,fifo_full,
				wr_en,rd_en);
	parameter Data_Depth = 256;
	parameter Data_Width = 8;
	parameter Add_Depth = 8;//256的bit位数
	input clk,rst_n,wr_en;
	input [Data_Width-1:0]in_data;
	output wire [Data_Width-1:0]out_data;
	output fifo_empty,fifo_full,rd_en;
	
	//定义fifo_mem
	reg[Data_Width-1:0] fifo_mem[Data_Depth];
	reg[Add_Depth-1:0]  wr_addr;
	reg[Add_Depth-1:0]  rd_addr;
	reg[Add_Depth:0]    counts; //计数的位数
	
	always@(posedge clk) begin
		if(!rst_n) begin
			integer i;
			for(i=0;i<Data_Depth;i=i+1) begin
				fifo_mem[i] = 'b0;
			end
		end
		else if(wr_en && !fifo_full)begin
			fifo_mem[wr_addr] <= in_data;
		end
	end
	
	always@(posedge clk) begin  //写入的计数
		if(!rst_n) begin
			wr_addr <= 'b0;
		end
		else if(wr_en && !fifo_full) begin
			wr_addr <= (wr_addr == Data_Depth-1)?'b0:wr_addr + 1'b1;
		end
	end
	
	always@(posedge clk) begin
		if(!rst_n) begin
			rd_addr <= 'b0;
		end
		else if(rd_en && !fifo_empty) begin
			rd_addr <= (rd_addr == Data_Depth-1)?'b0:rd_addr + 1'b1;
		end
	end
	
	always@(posedge clk) begin
		if(!rst_n) begin
			counts <= 'b0;
		end
		else if(wr_en && !fifo_full && !rd_en) begin
			counts <= counts + 1'b1;
		end
		else if(rd_en && !fifo_empty && !wr_en) begin
			counts <= counts - 1'b1;
		end
	end
	
	assign out_data = fifo_mem[rd_addr];
	assign fifo_empty = counts == 'b0;
	assign fifo_full  = counts == Data_Depth;
endmodule 
