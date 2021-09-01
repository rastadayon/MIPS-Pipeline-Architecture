module shifter #(parameter n, shift_amount) (input[n-1 : 0] in, output [n - 1 : 0] out);
  assign out = {in[n-shift_amount-1:0],{shift_amount{1'b0}}};
endmodule
