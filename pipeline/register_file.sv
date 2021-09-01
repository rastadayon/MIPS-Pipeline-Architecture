`timescale 1ns/1ns
module register_file (input clk, rst, reg_write, input[4:0] read_reg1, read_reg2, write_reg, input reg [31:0] write_data, output reg [31:0] read_data1, read_data2);
	reg [31:0] registers [0:31];
	integer i;
	always@(negedge clk, posedge rst) begin
		// if(rst) begin
		// 	for(i = 0; i < 32; i = i + 1)
		// 		registers[i] <= 32'b0;
		// end
		if(reg_write && write_reg != 5'b0)
			registers[write_reg] <= write_data;
	end
	integer j;
	initial begin
		registers[6] <= 32'd1; // sabete 1
		registers[7] <= 32'd0; // i
		registers[8] <= 32'd5;
		registers[0] <= 32'd0;
		registers[1] <= 32'd0;
		registers[9] <= 32'd0;
	end
	assign read_data1 = registers[read_reg1];
	assign read_data2 = registers[read_reg2];
endmodule

