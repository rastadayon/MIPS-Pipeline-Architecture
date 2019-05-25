module register #(parameter n = 32)(input clk, rst, ld, input[n-1 : 0] in, output reg[n-1 : 0] out);
	always@(posedge clk, posedge rst) begin
		if(rst)
			out <= {n{1'b0}};
		else if(ld)
			out <= in;
	end
endmodule
