`timescale 1ns/1ns
module ID_EXE(input clk, rst, input ID_EXE_mem_to_reg, ID_EXE_reg_write, input ID_EXE_mem_write, ID_EXE_mem_read, input ID_EXE_alu_src, ID_EXE_reg_dst, input [2:0] ID_EXE_alu_op, input [31:0] ID_pc_plus4, ID_rs, ID_rt, ID_immediate, input [4:0] ID_reg_address_rs, ID_reg_address_rt, ID_reg_address_rd, output reg ID_EXE_mem_to_reg_out, ID_EXE_reg_write_out, output reg ID_EXE_mem_write_out, ID_EXE_mem_read_out, output reg ID_EXE_alu_src_out, ID_EXE_reg_dst_out, output reg [2:0] ID_EXE_alu_op_out, output reg [31:0] EXE_pc_plus4, EXE_rs, EXE_rt, EXE_immediate, output reg [4:0] EXE_reg_address_rs, EXE_reg_address_rt, EXE_reg_address_rd);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			ID_EXE_mem_to_reg_out <= 1'b0;
			ID_EXE_reg_write_out <= 1'b0; 
			ID_EXE_mem_write_out <= 1'b0; 
			ID_EXE_mem_read_out <= 1'b0;
			ID_EXE_alu_src_out <= 1'b0;
			ID_EXE_reg_dst_out <= 1'b0;
			ID_EXE_alu_op_out <= 3'b0;
			EXE_pc_plus4 <= 32'b0;
			EXE_rs <= 32'b0;
			EXE_rt <= 32'b0;
			EXE_immediate <= 32'b0;
			EXE_reg_address_rs <= 5'b0;
			EXE_reg_address_rt <= 5'b0;
			EXE_reg_address_rd <= 5'b0;
		end
		else begin
			ID_EXE_mem_to_reg_out <= ID_EXE_mem_to_reg;
			ID_EXE_reg_write_out <= ID_EXE_reg_write; 
			ID_EXE_mem_write_out <= ID_EXE_mem_write; 
			ID_EXE_mem_read_out <= ID_EXE_mem_read;
			ID_EXE_alu_src_out <= ID_EXE_alu_src;
			ID_EXE_reg_dst_out <= ID_EXE_reg_dst;
			ID_EXE_alu_op_out <= ID_EXE_alu_op;
			EXE_pc_plus4 <= ID_pc_plus4;
			EXE_rs <= ID_rs;
			EXE_rt <= ID_rt;
			EXE_immediate <= ID_immediate;
			EXE_reg_address_rs <= ID_reg_address_rs;
			EXE_reg_address_rt <= ID_reg_address_rt;
			EXE_reg_address_rd <= ID_reg_address_rd;
		end
	end
endmodule
