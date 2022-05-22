`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    output reg         Branch,
    output reg         ALUSrc, //diff
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg, //diff
    output reg         Jump
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

assign opcode = instr_i[6:0];

/* Write your code HERE */

always @(*) begin
    if (opcode==7'b0110011) begin  // r-type
        ALUOp <= 2'b10;
        ALUSrc <= 1'b0;
        {Branch,MemRead,MemWrite} <= 3'b000;
        RegWrite <= 1'b1;
        MemtoReg <= 1'b0;
        Jump <= 1'b0;
    end
    else if(opcode==7'b0010011) begin // addi or slti  or slli
        ALUOp <= 2'b00;
        ALUSrc <= 1'b1;
        {Branch,MemRead,MemWrite} <= 3'b000;
        RegWrite <= 1'b1;
        MemtoReg <= 1'b0;
        Jump <= 1'b0;
    end
    else if(opcode==7'b0000011) begin // load
        ALUOp <= 2'b11;//temp
        ALUSrc <= 1'b1;
        {Branch,MemRead,MemWrite} <= 3'b010;
        RegWrite <= 1'b1;
        MemtoReg <= 1'b1;
        Jump <= 1'b0;
    end
    else if(opcode==7'b1100111) begin //jalr, use in return
        ALUOp <= 2'b00; // don't care
        ALUSrc <= 1'b1; //x
        {Branch,MemRead,MemWrite} <= 3'b000;
        RegWrite <= 1'b1;
        MemtoReg <= 1'b1; //x
        Jump <= 1'b1;
    end
    else if(opcode==7'b0100011) begin //store
        ALUOp <= 2'b00; 
        ALUSrc <= 1'b1;
        {Branch,MemRead,MemWrite} <= 3'b001;
        RegWrite <= 1'b0;
        MemtoReg <= 1'b1; //x
        Jump <= 1'b0;
    end
    else if(opcode==7'b1100011) begin //branch
        ALUOp <= 2'b01; 
        ALUSrc <= 1'b0;
        {Branch,MemRead,MemWrite} <= 3'b100;
        RegWrite <= 1'b0;
        MemtoReg <= 1'b1;//x
        Jump <= 1'b0;
    end
    else if(opcode==7'b1101111) begin // jal
        ALUOp <= 2'b00; // don't care
        ALUSrc <= 1'b1;//x
        {Branch,MemRead,MemWrite} <= 3'b000;
        RegWrite <= 1'b1;
        MemtoReg <= 1'b0;//x
        Jump <= 1'b1;
    end
    else begin
        ALUOp <= 2'b00;
        ALUSrc <= 1'b1;//x
        {Branch,MemRead,MemWrite} <= 3'b000;
        RegWrite <= 1'b0;
        MemtoReg <= 1'b0;//x
        Jump <= 1'b0;
    end
end
endmodule







