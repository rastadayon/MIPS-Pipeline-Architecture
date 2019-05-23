 `timescale 1ns/1ns
module data_memory(input clk, rst, mem_read, mem_write, input [31:0] address, write_data, output [31:0] read_data);
	reg [31:0] data_mem [0:1023];
	integer i;
	integer j;
	always@(posedge clk, posedge rst) begin
		if(rst)
			for(i = 0; i < 1024; i = i + 1)
				data_mem[i] <= 32'b0;

		else if(mem_write)
			data_mem[address] <= write_data;
	end
	
	assign read_data = (mem_read && address >= 0 && address < 1024) ? data_mem[address] : 32'b0;
endmodule


