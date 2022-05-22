`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */

always @(*) begin
	case (ALUOp)
		2'b00: begin// i-type sw jalr addi
			case(instr)
				4'b0000: ALU_Ctrl_o = 4'b0010; //addi add
				4'b0010: ALU_Ctrl_o = 4'b0111; //slti slt
				4'b0001: ALU_Ctrl_o = 4'b1001; //slli sll
				default: ALU_Ctrl_o = 4'b0010;
		    endcase
		end
		2'b01: ALU_Ctrl_o = 4'b0110; //beq
		2'b10: begin   // r-type
			case (instr)
				4'b0000: ALU_Ctrl_o = 4'b0010;//add
				4'b1000: ALU_Ctrl_o = 4'b0110;//subtract
				4'b0111: ALU_Ctrl_o = 4'b0000;//and
				4'b0110: ALU_Ctrl_o = 4'b0001;//or

				4'b0010: ALU_Ctrl_o = 4'b0111;//slt

				4'b1101: ALU_Ctrl_o = 4'b1000; //sra
				4'b0001: ALU_Ctrl_o = 4'b1001; //sll
				4'b0100: ALU_Ctrl_o = 4'b1010; //xor
			endcase
		end
		2'b11: ALU_Ctrl_o = 4'b0010; //for load
	endcase
end
endmodule
