module FU (output reg [1:0] frwrdA, frwrdB, input [4:0] EX_Rd, MEM_Rd, ID_Rs, ID_Rt, input EX_regWrite, MEM_regWrite);
	always@(*) begin
		frwrdA = 1'b0;
		frwrdB = 1'b0;


		if(EX_regWrite && EX_Rd == ID_Rs && EX_Rd != 5'b00000) // from MEM
			frwrdA = 2'd2;
		else if(MEM_regWrite && MEM_Rd == ID_Rs && MEM_Rd != 5'b00000) // from EXE
			frwrdA = 2'd1;
		


		if(EX_regWrite && EX_Rd == ID_Rt && EX_Rd != 5'b00000) // from MEM
			frwrdB = 2'd2;
		else if(MEM_regWrite && MEM_Rd == ID_Rt && MEM_Rd != 5'b00000) // from EXE
			frwrdB = 2'd1;
	end
endmodule
