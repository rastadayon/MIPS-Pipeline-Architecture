module pipeline (input clk, rst);
	//-------------------------------------------------
	wire pcLoad;
	wire [31 : 0] pcIn, pcOut;

	register PC (
		.clk(clk),
		.rst(rst),
		.in (pcIn),
		.out(pcOut),
		.ld(pcLoad)
	);


	//-------------------------------------------------
	wire [31 : 0] pcPlus4;

	adder pcAdder(
	.a(32'd4),
	.b(pcOut),
	.out(pcPlus4)
	);

	//----------------------------------------------------
	wire [31 : 0] inst;

	instruction_mem IM(
	.address(pcOut),
	.out_inst(inst)
	);

	//------------------------------------------------------
	wire flush;
	wire [31 : 0] IF_ID_pc_out, IF_ID_inst_out;
	wire IF_ID_write;

	IF_ID IF_ID_(
	.clk(clk),
	.rst(rst),
	.IF_ID_write(IF_ID_write),
	.flush(flush),
	.IF_ID_pc_plus4_in(pcPlus4),
	.IF_ID_inst_in(inst),
	.IF_ID_pc_plus4_out(IF_ID_pc_out), 
	.IF_ID_inst_out(IF_ID_inst_out)
	);

	//-----------------------------------------------------
	wire [31 : 0]beqBneAddress, jPC;
	wire [1 : 0]PCsrc;

	mux3to1 pcSrcMux(
	.in0(pcPlus4), 
	.in1(beqBneAddress), 
	.in2(jPC),
	.sel(PCsrc), 
	.out(pcIn)
	);

	//-----------------------------------------------------
	wire J, BEQ, BNE, equal, notEqual, nop;

	// new_hazard_unit hazardUnit(
	// .jump(J), 
	// .branch_equal(BEQ), 
	// .branch_not_equal(BNE), 
	// .equal(equal), 
	// .not_equal(notEqual), 
	// .flush(flush), 
	// .pc_ld(pcLoad), 
	// .IF_ID_write(IF_ID_write)
	// );

	hazard_unit HU(
	.branch_equal(BEQ),
	.branch_not_equal(BNE),
	.equal(equal),
	.not_equal(notEqual),
	.jump(J),
	.ID_EXE_mem_mem_read(ID_EX_memRead_out),
	.EXE_MEM_mem_mem_read(EX_MEM_memRead_out),
	.ID_EXE_reg_write(ID_EX_regWrite_out),
	.EXE_MEM_reg_write(EX_MEM_regWrite_out),
	.IF_ID_rs(IF_ID_inst_out[25 : 21]),
	.IF_ID_rt(IF_ID_inst_out[20 : 16]),
	.ID_EXE_reg_dest(ID_EX_regDest),
	.EXE_MEM_reg_dest(EX_MEM_Rd_out),
	.IF_ID_write(IF_ID_write),
	.pc_ld(pcLoad),
	.flush(flush),
	.nop(nop)
	);


	//-------------------------------------------------------
	wire NOP, RTYPE, LW, SW;
	wire memWrite, memRead, ALUsrc, regDest, regWrite, memToReg;
	wire [2 : 0] ALUop;

	cu CU(
	.opcode(IF_ID_inst_out[31 : 26]), 
	.func(IF_ID_inst_out[5 : 0]), 
	.equal(equal), 
	.notEqual(notEqual), 
	.Rtype(RTYPE), 
	.lw(LW), 
	.sw(SW), 
	.j(J) , 
	.beq(BEQ), 
	.bne(BNE), 
	.nop(NOP), 
	.memWrite(memWrite), 
	.memRead(memRead), 
	.ALUsrc(ALUsrc), 
	.regDest(regDest), 
	.regWrite(regWrite), 
	.memToReg(memToReg),  
	.ALUop(ALUop), 
	.PCsrc(PCsrc)
	);

	//-------------------------------------------------------------
	wire [31 : 0] readData1, readData2, writeDataOut;
	wire [4 : 0] MEM_WB_Rd_out;

	register_file registerFile(
	.clk(clk), 
	.rst(rst), 
	.reg_write(regWrite), 
	.read_reg1(IF_ID_inst_out[25:21]), 
	.read_reg2(IF_ID_inst_out[20:16]), 
	.write_reg(MEM_WB_Rd_out), 
	.write_data(writeDataOut), 
	.read_data1(readData1), 
	.read_data2(readData2)
	);

	//-----------------------------------------------------------

	comparator #(32)cmprtr(
	.in0(readData1), 
	.in1(readData2), 
	.equal(equal), 
	.notEqual(notEqual)
	);

	//---------------------------------------------------------

	// mux2to1  #(11) (
	// .in0(11'b0), 
	// .in1(), 
	// input sel, output [n-1 : 0] out);

	//---------------------------------------------------------
	wire [31 : 0] extendedADR;

	sign_extender SE(
	.in(IF_ID_inst_out[15:0]), 
	.out(extendedADR));

	//--------------------------------------------------------
	wire [31 : 0] shiftedADR;

	shifter #(32, 2) shifter_(
	.in(extendedADR), 
	.out(shiftedADR)
	);

	//---------------------------------------------------------

	adder branchAdder(
	.a(IF_ID_pc_out),
	.b(shiftedADR),
	.out(beqBneAddress)
	);

	//-------------------------------------------------------

	concatinator #(26, 2) cnctntr(
	.pc_up_bits(IF_ID_pc_out[31 : 28]), 
	.in(IF_ID_inst_out[25 : 0]), 
	.out(jPC)
	);

	//-----------------------------------------------------------
	wire [31 : 0] ID_EX_immidiate_out;
	wire ID_EX_memToReg_out, ID_EX_regWrite_out, ID_EX_memWrite_out, ID_EX_memRead_out, ID_EX_ALUsrc_out, ID_EX_regDest_out;
	wire [2:0] ID_EX_ALUop_out;
	wire [31:0] ID_EX_pcPlus4, ID_EX_readData1_out, ID_EX_readData2_out, ID_EX_address_out;
	wire [4:0] ID_EX_Rs_out, ID_EX_Rt_out, ID_EX_Rd_out;

	ID_EXE ID_EX(
	.clk(clk), 
	.rst(rst), 
	.ID_EXE_mem_to_reg_in(memToReg), 
	.ID_EXE_reg_write_in(regWrite), 
	.ID_EXE_mem_write_in(memWrite), 
	.ID_EXE_mem_read_in(memRead), 
	.ID_EXE_alu_src_in(ALUsrc), 
	.ID_EXE_reg_dst_in(regDest), 
	.ID_EXE_alu_op_in(ALUop), 
	.ID_EXE_pc_plus4_in(IF_ID_pc_out), 
	.ID_EXE_read_data1_in(readData1), 
	.ID_EXE_read_data2_in(readData2), 
	.ID_EXE_address_in(extendedADR), 
	.ID_EXE_rs_in(IF_ID_inst_out[25 : 21]), 
	.ID_EXE_rt_in(IF_ID_inst_out[20 : 16]), 
	.ID_EXE_rd_in(IF_ID_inst_out[15 : 11]), 
	.ID_EXE_mem_to_reg_out(ID_EX_memToReg_out), 
	.ID_EXE_reg_write_out(ID_EX_regWrite_out), 
	.ID_EXE_mem_write_out(ID_EX_memWrite_out), 
	.ID_EXE_mem_read_out(ID_EX_memRead_out), 
	.ID_EXE_alu_src_out(ID_EX_ALUsrc_out), 
	.ID_EXE_reg_dst_out(ID_EX_regDest_out), 
	.ID_EXE_alu_op_out(ID_EX_ALUop_out), 
	.ID_EXE_pc_plus4_out(ID_EX_pcPlus4), 
	.ID_EXE_read_data1_out(ID_EX_readData1_out), 
	.ID_EXE_read_data2_out(ID_EX_readData2_out), 
	.ID_EXE_address_out(ID_EX_address_out), 
	.ID_EXE_rs_out(ID_EX_Rs_out), 
	.ID_EXE_rt_out(ID_EX_Rt_out), 
	.ID_EXE_rd_out(ID_EX_Rd_out)
	);

	//--------------------------------------------------------
	wire [31 : 0] ID_EX_pcOut, ID_EX_data1, ID_EX_data2, EX_MEM_address_out, aluData2, A, B;
	wire [1 : 0] frwrdA, frwrdB;

	mux3to1 aSrcMux (
	.in0(ID_EX_data1), 
	.in1(EX_MEM_address_out), 
	.in2(writeDataOut), 
	.sel(frwrdA), 
	.out(A)
	);

	//-----------------------------------------------------------

	mux3to1 bSrcMux (
	.in0(ID_EX_data2), 
	.in1(EX_MEM_address_out), 
	.in2(writeDataOut), 
	.sel(frwrdB), 
	.out(aluData2)
	); 

	//-------------------------------------------------------------

	mux2to1 #(32) ALUbMux(
	.in0(aluData2), 
	.in1(ID_EX_immidiate_out), 
	.sel(ALUsrc), 
	.out(B)
	);

	//--------------------------------------------------------------
	wire [31 : 0] ALUres;

	ALU alu(
	.A(A), 
	.B(B), 
	.ALUop(ID_EX_ALUop_out), 
	.ALUres(ALUres)
	);

	//------------------------------------------------------------
	wire [4 : 0] ID_EX_regDest;

	mux2to1 #(5) regDestMux(
	.in0(ID_EX_Rt_out), 
	.in1(ID_EX_Rd_out), 
	.sel(ID_EX_regDest_out), 
	.out(ID_EX_regDest)
	);

	//------------------------------------------------------------
	wire EX_MEM_memToReg_out, EX_MEM_regWrite_out, EX_MEM_memWrite_out, EX_MEM_memRead_out;
	wire [31 : 0] EX_MEM_writeData_out ;
	wire [4 : 0] EX_MEM_Rd_out;

	EXE_MEM EX_MEM(
	.clk(clk), 
	.rst(rst), 
	.EXE_MEM_mem_to_reg_in(ID_EX_memToReg_out), 
	.EXE_MEM_reg_write_in(ID_EX_regWrite_out), 
	.EXE_MEM_mem_write_in(ID_EX_memWrite_out), 
	.EXE_MEM_mem_read_in(ID_EX_memRead_out), 
	.EXE_MEM_alu_res_in(ALUres), 
	.EXE_MEM_write_data_in(ID_EX_data2), 
	.EXE_MEM_reg_dest_in(ID_EX_regDest), 
	.EXE_MEM_mem_to_reg_out(EX_MEM_memToReg_out), 
	.EXE_MEM_reg_write_out(EX_MEM_regWrite_out), 
	.EXE_MEM_mem_write_out(EX_MEM_memWrite_out), 
	.EXE_MEM_mem_read_out(EX_MEM_memRead_out),
	.EXE_MEM_address_out(EX_MEM_address_out), 
	.EXE_MEM_write_data_out(EX_MEM_writeData_out), 
	.EXE_MEM_reg_dest_out(EX_MEM_Rd_out)
	);

	//------------------------------------------------------------
	wire MEM_WB_regWrite_out;

	FU fu(
	.frwrdA(frwrdA), 
	.frwrdB(frwrdB), 
	.EX_Rd(EX_MEM_Rd_out), 
	.MEM_Rd(MEM_WB_Rd_out), 
	.ID_Rs(ID_EX_Rs_out), 
	.ID_Rt(ID_EX_Rt_out), 
	.EX_regWrite(EX_MEM_regWrite_out), 
	.MEM_regWrite(MEM_WB_regWrite_out)
	);

	//---------------------------------------------------------
	wire [31 : 0] dataMemReadData;

	data_memory dataMemory(
	.clk(clk), 
	.rst(rst), 
	.mem_read(EX_MEM_memRead_out), 
	.mem_write(EX_MEM_memWrite_out), 
	.address(EX_MEM_address_out), 
	.write_data(EX_MEM_writeData_out), 
	.read_data(dataMemReadData)
	);

	//----------------------------------------------------------
	wire MEM_WB_memToReg_out;
	wire [31 : 0] MEM_WB_readData_out, MEM_WB_address_out;

	MEM_WB MEM_WB_(
	.clk(clk), 
	.rst(rst), 
	.MEM_WB_mem_to_reg_in(EX_MEM_memToReg_out), 
	.MEM_WB_reg_write_in(EX_MEM_regWrite_out),
	.MEM_WB_read_data_in(dataMemReadData), 
	.MEM_WB_address_in(EX_MEM_address_out), 
	.MEM_WB_reg_dest_in(EX_MEM_Rd_out),
	.MEM_WB_mem_to_reg_out(MEM_WB_memToReg_out), 
	.MEM_WB_reg_write_out(MEM_WB_regWrite_out), 
	.MEM_WB_read_data_out(MEM_WB_readData_out), 
	.MEM_WB_address_out(MEM_WB_address_out), 
	.MEM_WB_reg_dest_out(MEM_WB_Rd_out)
	);

	//-----------------------------------------------------

	mux2to1 #(32) WBmux(
	.in0(MEM_WB_address_out), 
	.in1(MEM_WB_readData_out), 
	.sel(MEM_WB_memToReg_out), 
	.out(writeDataOut)
	);

endmodule
