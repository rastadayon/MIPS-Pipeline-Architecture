`timescale 1ns/1ns
module EXE_MEM (input clk, rst, input [1:0] EXE_MEM_wb, input [1:0] EXE_MEM_mem, input [31:0] EXE_MEM_alu_res_in, EXE_MEM_rt_in, input [4:0] EXE_MEM_reg_dest, output reg [1:0] EXE_MEM_wb_out, output reg [31:0] EXE_MEM_alu_res_out, EXE_MEM_rt_out, output reg [4:0] EXE_MEM_reg_dest_out);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			EXE_MEM_wb_out <= 2'b0;
			EXE_MEM_alu_res_out <= 32'b0;
			EXE_MEM_rt_out <= 32'b0;
			EXE_MEM_reg_dest_out <= 5'b0;
		end
		else begin
			EXE_MEM_wb_out <= EXE_MEM_wb;
			EXE_MEM_alu_res_out <= EXE_MEM_alu_res_in;
			EXE_MEM_rt_out <= EXE_MEM_rt_in;
			EXE_MEM_reg_dest_out <= EXE_MEM_reg_dest;
		end
	end
endmodule								   
