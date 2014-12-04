`include "InstructionDecoder.v"
`include "ALU.v"
`include "RegisterFile.v"

module CPU(clk);
input clk;

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc;
wire[0:15] Imm16;
wire[0:2] ALUOp;
wire[0:4] Rt, Rs, Rd;

endmodule


module TestCPU;
reg clk;

reg[31:0] instruction = 32'b00000011111000001000100000100000;
wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc;
wire[15:0] Imm16;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd;
wire result, carryout, overflow, zero;
wire[31:0] ReadData1, ReadData2, WriteData;

InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc);
RegisterFile regfile(ReadData1, ReadData2, WriteData, Rs, Rt, Rd, WrEn, clk);
ALU alu(result, carryout, overflow, zero, Rs, Rt, ALUOp);

initial $display("fuuuuck me");
endmodule
