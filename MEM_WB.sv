`timescale 1ns/1ns
module MEM_WB (input clk, rst, input MEM_WB_mem_to_reg, MEM_WB_reg_write, input [31:0] MEM_WB_read_data, MEM_WB_alu_res, input [4:0] MEM_WB_reg_dest, output reg MEM_WB_mem_to_reg_out, MEM_WB_reg_write_out, output reg [31:0] MEM_WB_read_data_out, MEM_WB_alu_res_out, output reg [4:0] MEM_WB_reg_dest_out);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			MEM_WB_mem_to_reg_out <= 1'b0;
			MEM_WB_reg_write_out <= 1'b0;
			MEM_WB_read_data_out <= 32'b0;
			MEM_WB_alu_res_out <= 32'b0;
			MEM_WB_reg_dest_out <= 5'b0;
		end // if (rst)
		else begin
			MEM_WB_mem_to_reg_out <= MEM_WB_mem_to_reg;
			MEM_WB_reg_write_out <= MEM_WB_reg_write;
			MEM_WB_read_data_out <= MEM_WB_read_data;
			MEM_WB_alu_res_out <= MEM_WB_alu_res;
			MEM_WB_reg_dest_out <= MEM_WB_reg_dest;
		end
	end
endmodule // MEM_WB