`timescale 1ns/1ns
module ID_EXE(input clk, rst, input ID_EXE_mem_to_reg_in, ID_EXE_reg_write_in, ID_EXE_Rtype_in, ID_EXE_lw_in, ID_EX_sw_in, ID_EX_j_in , ID_EX_beq_in, ID_EX_bne_in, ID_EX_nop_in, input ID_EXE_mem_write_in, ID_EXE_mem_read_in,
 input ID_EXE_alu_src_in, ID_EXE_reg_dst_in, input [2:0] ID_EXE_alu_op_in, input [31:0] ID_EXE_pc_plus4_in, ID_EXE_read_data1_in, ID_EXE_read_data2_in, ID_EXE_address_in, 
 input [4:0] ID_EXE_rs_in, ID_EXE_rt_in, ID_EXE_rd_in, output reg ID_EXE_mem_to_reg_out, ID_EXE_reg_write_out, ID_EXE_Rtype_out, ID_EXE_lw_out, ID_EX_sw_out, ID_EX_j_out , ID_EX_beq_out, ID_EX_bne_out, ID_EX_nop_out, 
 output reg ID_EXE_mem_write_out, ID_EXE_mem_read_out, output reg ID_EXE_alu_src_out, ID_EXE_reg_dst_out, output reg [2:0] ID_EXE_alu_op_out, output reg [31:0] 
 ID_EXE_pc_plus4_out, ID_EXE_read_data1_out, ID_EXE_read_data2_out, ID_EXE_address_out, output reg [4:0] ID_EXE_rs_out, ID_EXE_rt_out, ID_EXE_rd_out);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			ID_EXE_mem_to_reg_out <= 1'b0;
			ID_EXE_reg_write_out <= 1'b0; 
			ID_EXE_mem_write_out <= 1'b0; 
			ID_EXE_mem_read_out <= 1'b0;
			ID_EXE_alu_src_out <= 1'b0;
			ID_EXE_reg_dst_out <= 1'b0;
			ID_EXE_alu_op_out <= 3'b0;
			ID_EXE_pc_plus4_out <= 32'b0;
			ID_EXE_read_data1_out <= 32'b0;
			ID_EXE_read_data2_out <= 32'b0;
			ID_EXE_address_out <= 32'b0;
			ID_EXE_rs_out <= 5'b0;
			ID_EXE_rt_out <= 5'b0;
			ID_EXE_rd_out <= 5'b0;
			ID_EXE_Rtype_out <= 1'b0; 
			ID_EXE_lw_out <= 1'b0;
			ID_EX_sw_out <= 1'b0;
			ID_EX_j_out <= 1'b0;
			ID_EX_beq_out <= 1'b0;
			ID_EX_bne_out <= 1'b0;
			ID_EX_nop_out <= 1'b0; 
		end
		else begin
			ID_EXE_mem_to_reg_out <= ID_EXE_mem_to_reg_in;
			ID_EXE_reg_write_out <= ID_EXE_reg_write_in; 
			ID_EXE_mem_write_out <= ID_EXE_mem_write_in; 
			ID_EXE_mem_read_out <= ID_EXE_mem_read_in;
			ID_EXE_alu_src_out <= ID_EXE_alu_src_in;
			ID_EXE_reg_dst_out <= ID_EXE_reg_dst_in;
			ID_EXE_alu_op_out <= ID_EXE_alu_op_in;
			ID_EXE_pc_plus4_out <= ID_EXE_pc_plus4_in;
			ID_EXE_read_data1_out <= ID_EXE_read_data1_in;
			ID_EXE_read_data2_out <= ID_EXE_read_data2_in;
			ID_EXE_address_out <= ID_EXE_address_in;
			ID_EXE_rs_out <= ID_EXE_rs_in;
			ID_EXE_rt_out <= ID_EXE_rt_in;
			ID_EXE_rd_out <= ID_EXE_rd_in;
			ID_EXE_Rtype_out <= ID_EXE_Rtype_in; 
			ID_EXE_lw_out <= ID_EXE_lw_in;
			ID_EX_sw_out <= ID_EX_sw_in;
			ID_EX_j_out <= ID_EX_j_in;
			ID_EX_beq_out <= ID_EX_beq_in;
			ID_EX_bne_out <= ID_EX_bne_in;
			ID_EX_nop_out <= ID_EX_nop_in; 
		end
	end
endmodule
