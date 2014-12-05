`include "InstructionDecoder.v"
`include "ALU.v"
`include "DataMemory.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"
`include "Odds_Ends.v"

module CPU(clk, custom_instruction, out, s0, pc, inst);
input clk;
input[31:0] custom_instruction;
output[31:0] out,s0,pc,inst;

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc, Sign, Bananna, carryout, overflow, zero, regWE;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd, RegDestOut;
wire[15:0] Imm16;
wire[25:0] Imm26;
wire[31:0] BanannaOut, ALUSrcOut, MemOutOut, SEOut, PCOut, dataOut, result, ReadData1, ReadData2, instruction;

assign out = BanannaOut;
assign pc = PCOut;
assign inst=instruction;
//assign instruction=custom_instruction

ProgramCounter PC(clk, PCWr, MemOutOut, PCSrc, SEOut, PCOut, zero);
memory mem(clk, regWE, PCOut, MemOutOut, instruction);
InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc, Bananna, regWE);
mux32to1by2 BanannaMux(BanannaOut, Bananna, MemOutOut, PCOut);
mux5to1by2 RegDestMux(RegDestOut, RegDst, Rd, Rt);
RegisterFile regfile(ReadData1, ReadData2, BanannaOut, Rs, Rt, RegDestOut, RegWr, clk, s0);
SignExtend se(Imm16, Imm26, SEOut, Sign, clk);
mux32to1by2 ALUSrcMux(ALUSrcOut, ALUSrc, ReadData2, SEOut);
ALU alu(result, carryout, zero, overflow, ReadData1, ALUSrcOut, ALUOp);
DataMemory dm(clk, dataOut, result, DmWr, ReadData2);
mux32to1by2 MemOutMux(MemOutOut, MemOut, result, dataOut);
endmodule

module CPUtest;
reg clk;
reg[31:0] instruction;
wire[31:0] status, s0, pc, inst;
CPU cpu(clk,instruction, status, s0, pc, inst);
initial clk = 0;
always #50 clk=!clk;

initial begin
instruction = 32'b00100000000100010000000000000101; // store 5 in 17(s1)
#25
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0); #100
instruction = 32'b00100000000100100000000000010011; // store 19 in 18(s2) 
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0); #100
instruction = 32'b00000010001100101000000000100000; // store their sum in  16(s0)
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0); #100
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0); #100
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0); #100
$display($time, ": pc: %h instruction: %h status: %b  s0: %d",pc,inst,status,s0);
end
endmodule