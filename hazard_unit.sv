module hazard_unit(input [5:0] op_code, input equal, not_equal, ID_EXE_mem_mem_read, EXE_MEM_mem_mem_read, ID_EXE_reg_write, EXE_MEM_reg_write, input [4:0] IF_ID_rs, IF_ID_rt, ID_EXE_reg_dest, EXE_MEM_reg_dest, output reg IF_ID_write, pc_ld, flush, nop);
	reg stall = 0;
	wire branch_equal, jump, branch_not_equal;
	parameter BEQ = 6'b000100, BNE = 6'b000101, JUMP = 6'b000010;
	assign branch_equal = (op_code == BEQ) ? 1'b1: 1'b0;
	assign branch_not_equal = (op_code == 6'b000101) ? 1'b1 : 1'b0;
	assign jump = (op_code == JUMP) ? 1'b1 : 1'b0;
	// if (op_code == BNE) begin
	// 	$display("biaaaaaaaaaaaaaaaaaaaaaaaaaaaaa injaaaaaaaaaaaaaaaaaaaaaa"); end
	always@(*) begin
		stall = 0;
		flush = 0;
		pc_ld = 1;
		IF_ID_write = 1;
		nop = 0;

		//stall after lw with data hazard
		if(ID_EXE_mem_mem_read && ( (IF_ID_rs == ID_EXE_reg_dest) || (IF_ID_rt == ID_EXE_reg_dest) ) && ID_EXE_reg_dest != 5'b0 ) begin
			$display("stallllllllllllllll for lwwwwwwwwwwwwwwwwwwwww");
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
			$display("firsssssssssssssssst stalllllllllllllllllllllllllllllllllll");
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//second stall
		if( (branch_equal || branch_not_equal) && EXE_MEM_reg_write && ( (IF_ID_rs == EXE_MEM_reg_dest) || (IF_ID_rt == EXE_MEM_reg_dest) ) && EXE_MEM_reg_dest != 5'b0 ) begin
			$display("seccccooonddddddddddddddddddddddddddd stalllllllllllllllllllllllll");
			stall = 1;
			pc_ld = 0;
			IF_ID_write = 0;
			nop = 1;
		end

		//flush after jump
		if(jump && ~stall)
			flush = 1;

		//flush after beq or bneq
		if( (branch_equal && equal) || (branch_not_equal && not_equal) && ~stall)
			flush = 1;
	end
endmodule // hazard_unit