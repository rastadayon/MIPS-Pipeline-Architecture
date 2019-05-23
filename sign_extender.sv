module sign_extender(input [15:0] in, output [31:0] out);
  reg [31:0] temp;
  assign temp = (in[15] == 1) ? {~(16'b0), in}:
    {16'b0, in};
  assign out = temp;
endmodule
