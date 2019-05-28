`timescale 1ns/1ns
module IF_ID (input clk, rst, IF_ID_write, flush, input [31:0]IF_ID_pc_plus4_in, IF_ID_inst_in, output reg [31:0]IF_ID_pc_plus4_out, IF_ID_inst_out);
	always@(posedge clk, posedge rst) begin
		if(rst || flush) begin
			IF_ID_pc_plus4_out <= 32'b0;
			IF_ID_inst_out <= 32'b0;
		end
		else if(IF_ID_write) begin
			IF_ID_pc_plus4_out <= IF_ID_pc_plus4_in;
			IF_ID_inst_out <= IF_ID_inst_in;
		end
		else if (~IF_ID_write) begin
			IF_ID_pc_plus4_out <= IF_ID_pc_plus4_out;
			IF_ID_inst_out <= IF_ID_inst_out;
		end
	end
endmodule