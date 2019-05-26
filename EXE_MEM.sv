`timescale 1ns/1ns
module EXE_MEM (input clk, rst, input EXE_MEM_mem_to_reg_in, EXE_MEM_reg_write_in, input EXE_MEM_mem_write_in, EXE_MEM_mem_read_in, input [31:0] EXE_MEM_alu_res_in, EXE_MEM_write_data_in, input [4:0] EXE_MEM_reg_dest_in, output reg EXE_MEM_mem_to_reg_out, EXE_MEM_reg_write_out, output reg EXE_MEM_mem_write_out, EXE_MEM_mem_read_out, output reg [31:0] EXE_MEM_address_out, EXE_MEM_write_data_out, output reg [4:0] EXE_MEM_reg_dest_out);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			EXE_MEM_mem_to_reg_out <= 1'b0;
			EXE_MEM_reg_write_out <= 1'b0;
			EXE_MEM_mem_write_out <= 1'b0;
			EXE_MEM_mem_read_out <= 1'b0;
			EXE_MEM_address_out <= 32'b0;
			EXE_MEM_write_data_out <= 32'b0;
			EXE_MEM_reg_dest_out <= 5'b0;
		end
		else begin
			EXE_MEM_mem_to_reg_out <= EXE_MEM_mem_to_reg_in;
			EXE_MEM_reg_write_out <= EXE_MEM_reg_write_in;
			EXE_MEM_mem_write_out <=  EXE_MEM_mem_write_in;
			EXE_MEM_mem_read_out <= EXE_MEM_mem_read_in;
			EXE_MEM_address_out <= EXE_MEM_alu_res_in;
			EXE_MEM_write_data_out <= EXE_MEM_write_data_in;
			EXE_MEM_reg_dest_out <= EXE_MEM_reg_dest_in;
		end
	end
endmodule								   
