module ATB ();
	reg clk = 0, rst = 0;
	pipe test(clk, rst);

	always #50 clk = ~clk;

	initial begin
		#70;
		rst = 1;
		#70;
		rst = 0;
		#70;
	end

endmodule
