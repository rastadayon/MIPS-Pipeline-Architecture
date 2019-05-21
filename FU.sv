module FU (output reg [1:0] frwrdA, frwrdB, input [4:0] EX_Rd, MEM_Rd, ID_Rs, ID_Rt, input EX_regWrite, MEM_regWrite);
	always@(EX_Rd, MEM_Rd, ID_Rs, ID_Rt, EX_regWrite, MEM_regWrite) begin
		frwrdA = 1'b1;
		frwrdB = 1'b1;
		if(MEM_regWrite && EX_Rd != 5'b0 && EX_Rd == ID_Rs)
			frwrdA = 2'd2;
		else if(MEM_regWrite && EX_Rd != 5'b0 && MEM_Rd == ID_Rs)
			frwrdA = 2'b1;
		
		if(MEM_regWrite && EX_Rd != 5'b0 && EX_Rd == ID_Rt)
			frwrdB = 2'd2;
		else if(MEM_regWrite && EX_Rd != 5'b0 && MEM_Rd == ID_Rt)
			frwrdB = 2'd1;
	end
endmodule
