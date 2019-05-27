module comparator #(parameter n)(input [n-1 : 0] in0, in1, output reg equal, notEqual);
	/*assign equal = (in0 == in1) ? 1'b1 :
	1'b0;
	assign notEqual = (in0 != in1) ? 1'b1 :
	1'b0;*/
	always@(in0,in1) begin
		if (in0 == in1)
			equal <= 1'b1;
		else
			notEqual <= 1'b1;
	end
endmodule
