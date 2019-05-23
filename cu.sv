module cu(input [5:0] opcode, func, output reg Rtype, lw, sw, j , beq, bne, memWrite, memRead, ALUsrc, regDest, regWrite, memToReg,  output reg [2:0] ALUop);
	always@(opcode, func) begin
		case(opcode)
			6'b000000: begin //Rtype
				Rtype <= 1'b1; memRead <= 1'b0; memWrite <= 1'b0; memToReg <= 1'b0; ALUsrc <= 1'b0; regDest <= 1'b1; regWrite <= 1'b1; memToReg <= 1'b0;
				case(func)
					6'b1000000: ALUop <= 3'b000; //add
					6'b1000010: ALUop <= 3'b001; //sub
					6'b100100: ALUop <= 3'b010; //and
					6'b100101: ALUop <= 3'b011; //or
					6'b101010: ALUop <= 3'b100; //slt
					default: ALUop <= 3'b111; //nop
				endcase
			end
			6'b100011: begin
				lw <= 1'b1; memRead <= 
			end
		endcase
	end
	
endmodule
