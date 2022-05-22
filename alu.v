`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */
always @(*) begin
    if (~rst_n)
        result <= 32'b0;
    else begin
        if(ALU_control==4'b0010) begin  // add
            result <= src1 + src2;
        end
        else if (ALU_control==4'b0110) begin  //subtract
            result <= src1 - src2;
        end
        else if(ALU_control==4'b0111) begin  //slt
            result <= src1 < src2;
        end
        else if(ALU_control==4'b1000)
			result <= src1 >>> src2;//sra
		else if(ALU_control==4'b1001)
			result <= src1 << src2;//sll
		else if(ALU_control==4'b1010)
			result <= src1 ^ src2;//xor
        else if(ALU_control==4'b0001)
            result <= src1 | src2;//or
        else if(ALU_control==4'b0000)
            result <= src1 & src2;//and
    end
end

always @(*) begin
    if (~rst_n)
        zero <= 1'b1;
    else
        zero <= ~| result;
end

endmodule
