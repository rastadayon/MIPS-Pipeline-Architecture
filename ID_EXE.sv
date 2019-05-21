`timescale 1ns/1ns
module ID_EXE(input clk, rst, input [1:0] wb, input [1:0] mem, input [5:0] exe, input [31:0] ID_pc_plus4, ID_rs, ID_rt, ID_immediate, input [4:0] ID_reg_address_rs, ID_reg_address_rt, ID_reg_address_rd, output reg [1:0] wb_out, output reg [1:0] mem_out, output reg [5:0] exe_out, output reg [31:0] EXE_pc_plus4, EXE_rs, EXE_rt, EXE_immediate, output reg [4:0] EXE_reg_address_rs, EXE_reg_address_rt, EXE_reg_address_rd);
	always@(posedge clk, posedge rst) begin
		if (rst) begin
			wb_out  <= 2'b0;
			mem_out  <= 2'b0;
			exe_out <= 6'b0;
			EXE_pc_plus4 <= 32'b0;
			EXE_rs <= 32'b0;
			EXE_rt <= 32'b0;
			EXE_immediate <= 32'b0;
			EXE_reg_address_rs <= 5'b0;
			EXE_reg_address_rt <= 5'b0;
			EXE_reg_address_rd <= 5'b0;
		end
		else begin
			wb_out  <= wb;
			mem_out <= mem;
			exe_out <= exe;
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
