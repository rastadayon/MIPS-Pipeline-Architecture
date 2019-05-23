module comparator #(parameter n)(input [n-1 : 0] in0, in1, output equal, notEqual);
	assign equal = (in0 == in1) ? 1'b1 :
	1'b0;
	assign notEqual = (in0 != in1) ? 1'b1 :
	1'b0;
endmodule
