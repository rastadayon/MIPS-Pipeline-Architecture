module concatinator #(parameter n, zero_amount) (input [3:0] pc_up_bits, input [n - 1 : 0] in, output [n + zero_amount + 3 : 0] out);
	assign out = {pc_up_bits, in , {zero_amount{1'b0}} };
endmodule // shifter
