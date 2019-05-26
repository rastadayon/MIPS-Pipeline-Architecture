module hazard_unit(input branch_equal, branch_not_equal, equal, not_equal, jump, ID_EXE_mem_mem_read, EXE_MEM_mem_mem_read, ID_EXE_reg_write, EXE_MEM_reg_write, input [4:0] IF_ID_rs, IF_ID_rt, ID_EXE_reg_dest, EXE_MEM_reg_dest, output reg IF_ID_write, pc_ld, flush, nop);
	reg stall = 0;
	always@(*) begin
		stall = 0;
		flush = 0;
		pc_ld = 1;
		IF_ID_write = 1;
		nop = 0;

		//stall after lw with data hazard
		if( ID_EXE_mem_mem_read && ( (IF_ID_rs == ID_EXE_reg_dest) || (IF_ID_rt == ID_EXE_reg_dest) ) && ID_EXE_reg_dest != 5'b0 ) begin
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//if beq or bneq after lw with data hazard
		if( (branch_equal || branch_not_equal) && EXE_MEM_mem_mem_read && ( (IF_ID_rs == EXE_MEM_reg_dest) || (IF_ID_rt == EXE_MEM_reg_dest) ) && EXE_MEM_reg_dest != 5'b0 ) begin
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//beq or bneq after r_type with data hazard
		if( (branch_equal || branch_not_equal) && ID_EXE_reg_write && ( (IF_ID_rs == ID_EXE_reg_dest) || (IF_ID_rt == ID_EXE_reg_dest) ) && ID_EXE_reg_dest != 5'b0 ) begin
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//second stall
		if( (branch_equal || branch_not_equal) && EXE_MEM_reg_write && ( (IF_ID_rs == EXE_MEM_reg_dest) || (IF_ID_rt == EXE_MEM_reg_dest) ) && EXE_MEM_reg_dest != 5'b0 ) begin
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//flush after jump
		if(jump)
			flush = 1;

		//flush after beq or bneq
		if( (branch_equal && equal) || (branch_not_equal && not_equal) )
			flush = 1;
	end
endmodule // hazard_unit