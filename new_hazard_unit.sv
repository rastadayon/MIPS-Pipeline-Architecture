module new_hazard_unit( input jump, branch_equal, branch_not_equal, equal, not_equal, output reg flush, pc_ld, IF_ID_write);
	always@(*) begin
		flush = 0;
		IF_ID_write = 1;
		pc_ld = 1;

		//nop
		/*if(nop) begin
			IF_ID_write = 0;
			pc_ld = 0;
		end*/
		//flush after jump
		if(jump)
			flush = 1;

		//flush after beq or bneq
		if( (branch_equal && equal) || (branch_not_equal && not_equal) )
			flush = 1;

	end
endmodule // new_hazard_unit
