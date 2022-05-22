`timescale 1ns/1ps

module Imm_Gen(
    input      [31:0] instr_i,
    output reg [31:0] Imm_Gen_o
);

/* Write your code HERE */
wire    [7-1:0] opcode;
assign opcode = instr_i[6:0];
always @(*) begin
    if (opcode==7'b0110011) begin  // r-type
        Imm_Gen_o = 0;
    end
    else if(opcode==7'b0010011||opcode==7'b0000011||opcode==7'b1100111) begin // addi, load, jalr
        Imm_Gen_o = {{20{instr_i[31]}},instr_i[31:20]};
    end
    else if(opcode==7'b0100011) begin //store
        Imm_Gen_o = {{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]};
    end
    else if(opcode==7'b1100011) begin //branch
        Imm_Gen_o = {{20{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]};
        // Imm_Gen_o = Imm_Gen_o;
    end
    else if(opcode==7'b1101111) begin // jal
        Imm_Gen_o = {{12{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
        // Imm_Gen_o = Imm_Gen_o;
    end
end

endmodule
