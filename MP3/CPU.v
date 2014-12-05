`include "InstructionDecoder.v"
`include "ALU.v"
`include "DataMemory.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"
`include "Odds_Ends.v"

module CPU(clk, instruction, out, s0);
input clk;
input[31:0] instruction;
output[31:0] out;
output[31:0] s0;

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc, Sign, Bananna, carryout, overflow, zero;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd, RegDestOut;
wire[15:0] Imm16;
wire[31:0] BanannaOut, ALUSrcOut, MemOutOut, SEOut, PCOut, dataOut, result, ReadData1, ReadData2;

assign out = Rs;

ProgramCounter pc(clk, PCWr, MemOutOut, PCSrc, SEOut, PCOut, zero);
InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc, Bananna);
mux32to1by2 BanannaMux(BanannaOut, Bananna, MemOutOut, PCOut);
mux5to1by2 RegDestMux(RegDestOut, RegDst, Rd, Rt);
RegisterFile regfile(ReadData1, ReadData2, BanannaOut, Rs, Rt, RegDestOut, RegWr, clk, s0);
SignExtend se(Imm16, SEOut, Sign, clk);
mux32to1by2 ALUSrcMux(ALUSrcOut, ALUSrc, ReadData2, SEOut);
ALU alu(result, carryout, zero, overflow, ReadData1, ALUSrcOut, ALUOp);
DataMemory dm(clk, dataOut, result, DmWr, ReadData2);
mux32to1by2 MemOutMux(MemOutOut, MemOut, result, dataOut);
endmodule

module CPUtest;
reg clk;
reg[31:0] instruction;
wire[31:0] res, s0;
CPU cpu(clk,instruction, res, s0);
initial begin
instruction = 32'b00100010000100001010101010101010; // this is an addi instruction
//instruction = 32'b00000010001100011000000000100000; // this is an add instruction
clk = 0;
end
always #50 clk=!clk;

initial begin
instruction = 32'b00100000000100010000000000000101; // store 5 in 17(s1)
$display($time, ": res: %b  s0: %b", res,s0); #25
$display($time, ": res: %b  s0: %b", res,s0); #75
instruction = 32'b00100000000100100000000000010011; // store 19 in 18(s2) 
$display($time, ": res: %b  s0: %b", res,s0); #100
instruction = 32'b00000010001100101000000000100000; // store their sum in  16(s0)
$display($time, ": res: %b  s0: %b", res,s0); #100
$display($time, ": res: %b  s0: %b", res,s0); #100
$display($time, ": res: %b  s0: %b", res,s0); #100
$display($time, ": res: %b  s0: %b", res,s0);
end
endmodule