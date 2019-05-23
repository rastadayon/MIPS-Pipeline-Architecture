module ALU (input[31:0] A, B, input[2:0] ALUop, output reg [31:0] ALUres);
	always@(A, B, ALUop) begin
		ALUres = 32'b0;
		case(ALUop)
			3'b000 : ALUres = A + B;
			3'b001 : ALUres = A - B;  
			3'b010 : ALUres = A & B;
			3'b011 : ALUres = A | B;
			3'b100 : ALUres = (A < B) ? 32'd1 : 32'b0;
			3'b111 : ALUres = ALUres;
			default : ALUres = 32'b0;
		endcase
	end
endmodule
		
