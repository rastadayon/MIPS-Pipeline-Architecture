`timescale 1ns/1ns
module EXE_MEM (input clk, rst, input EXE_MEM_mem_to_reg, EXE_MEM_reg_write, input EXE_MEM_mem_write, EXE_MEM_mem_read, input [31:0] EXE_MEM_alu_res_in, EXE_MEM_rt_in, input [4:0] EXE_MEM_reg_dest, output reg EXE_MEM_mem_to_reg_out, EXE_MEM_reg_write_out, output reg [31:0] EXE_MEM_alu_res_out, EXE_MEM_rt_out, output reg [4:0] EXE_MEM_reg_dest_out);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			EXE_MEM_mem_to_reg_out <= 1'b0;
			EXE_MEM_reg_write_out <= 1'b0;
			EXE_MEM_alu_res_out <= 32'b0;
			EXE_MEM_rt_out <= 32'b0;
			EXE_MEM_reg_dest_out <= 5'b0;
		end
		else begin
			EXE_MEM_mem_to_reg_out <= EXE_MEM_mem_to_reg;
			EXE_MEM_reg_write_out <= EXE_MEM_reg_write;
			EXE_MEM_alu_res_out <= EXE_MEM_alu_res_in;
			EXE_MEM_rt_out <= EXE_MEM_rt_in;
			EXE_MEM_reg_dest_out <= EXE_MEM_reg_dest;
		end
	end
endmodule								   
