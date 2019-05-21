`timescale 1ns/1ns
module IF_ID (input clk, rst, IF_ID_write, flush, input [31:0]IF_pc_plus4, IF_inst_in, output reg [31:0]ID_pc_plus4, ID_inst_out);
	always@(posedge clk, posedge rst) begin
		if(rst || flush) begin
			ID_pc_plus4 <= 32'b0;
			ID_inst_out <= 32'b0;
		end
		else if(IF_ID_write) begin
			ID_pc_plus4 <= IF_pc_plus4;
			ID_inst_out <= IF_inst_in;
		end
	end
endmodule