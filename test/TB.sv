module ATB ();
	reg clk = 0, rst = 0;
	new_pipeline test(clk, rst);

	always #50 clk = ~clk;

	initial begin
		#70;
		rst = 1;
		#70;
		rst = 0;
		//#460
		//$stop;
		
	end

endmodule
