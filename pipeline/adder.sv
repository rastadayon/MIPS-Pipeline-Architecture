module adder #(parameter n = 32) (input signed [n-1:0] a,b, output signed [n-1:0] out);
  assign out = a + b;
endmodule
