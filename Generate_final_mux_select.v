`timescale 1ns/1ps

module Generate_final_mux_select(
    input       jump,
    input       regwrite,
    input       memtoreg,
    output  reg [1:0] select
);
/* Write your code HERE */

always @(*) begin
    if(jump==1'b1) begin
        select = 2'b10;
    end
    else if(regwrite==1'b1) begin
        if (memtoreg==1'b1) begin
            select = 2'b00;
        end
        else begin
            select = 2'b01;
        end
    end
    else begin
        select = 2'b11;//don't care
    end
end

endmodule

