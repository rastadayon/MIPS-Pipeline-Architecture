`timescale 1ns/1ns
module mux2to1  #(parameter n) (input[n-1 : 0] in0, in1, input sel, output [n-1 : 0] out);
	assign out = sel ? in1 :
				 (~sel) ? in0 :
				 out;
endmodule
