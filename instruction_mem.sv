`timescale 1ns/1ns
module instruction_mem #(parameter n = 32'd4294967295, width = 8, pc = 32)(input[pc-1 : 0] address, output [width-1 : 0] out_inst);
	reg [width-1:0] insts [0:n-1];
  	assign out_inst = (address >= 0 && address < n) ? insts[address] : {n{1'b0}};
endmodule


