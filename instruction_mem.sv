`timescale 1ns/1ns
module instruction_mem #(parameter n, width, pc)(input[pc-1 : 0] address, output [width-1 : 0] out_inst, output [width-1:0] test_inst [0:n-1]);
	reg [width-1:0] insts [0:n-1];
  	assign out_inst = (address >= 0 && address < n) ? insts[address] : {n{1'b0}};
  	assign test_inst = insts;
endmodule


