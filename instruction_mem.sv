`timescale 1ns/1ns
module instruction_mem #(parameter n = 400, width = 8, pc = 32)(input[pc-1 : 0] address, output [pc-1 : 0] out_inst); //32'd4294967295
	reg [width-1:0] insts [0:n-1];
	integer i;
	initial begin
		for(i = 0; i < n; i = i + 4) begin
			{insts[i], insts[i+1], insts[i+2], insts[i+3]} = 32'b0; // nop
		end
	end
	initial begin
		$readmemb("instructions.txt", insts);
	end
  	assign out_inst = (address >= 0 && address < n) ? {insts[address], insts[address + 1], insts[address + 2], insts[address + 3]} : {4*width{1'b0}};
endmodule


