module mux3to1 #(parameter n)(input [n-1 : 0] in0, in1, in2, input [1 : 0] sel, output out);
	assign out = (sel == 2'd0) ? in0 : (sel == 2'd1) ? in1 : (sel == 2'd2) ? in2 : out;
endmodule
