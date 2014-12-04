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

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc, Sign, Bananna;
wire[15:0] Imm16;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd;
wire[4:0] RegDestOut;
wire[31:0] BanannaOut, ALUSrcOut, MemOutOut, SEOut, PCOut;
wire[31:0] dataOut;
wire[31:0] result;
wire carryout, overflow, zero;
wire[31:0] ReadData1, ReadData2;

assign out = Rs;

mux5to1by2 RegDestMux(RegDestOut, RegDst, Rd, Rt);
mux32to1by2 BanannaMux(BanannaOut, Bananna, MemOutOut, PCOut);
mux32to1by2 ALUSrcMux(ALUSrcOut, ALUSrc, ReadData2, SEOut);
mux32to1by2 MemOutMux(MemOutOut, MemOut, result, dataOut);
DataMemory dm(clk, dataOut, result, DmWr, ReadData2);
InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc, Bananna);
RegisterFile regfile(ReadData1, ReadData2, BanannaOut, Rs, Rt, RegDestOut, RegWr, clk, s0);
ALU alu(result, carryout, zero, overflow, ReadData1, ALUSrcOut, ALUOp);
ProgramCounter pc(clk,WrEn,MemOutOut,PCSrc,SEOut, PCOut,zero);
SignExtend se(Imm16, SEOut, Sign, clk);
initial begin

end
endmodule

module CPUtest;
reg clk;
reg[31:0] instruction;
reg[31:0] res;
wire[31:0] s0;
//initial instruction = 32'b00000010001100101000000000100000; // this is an add instruction
initial instruction = 32'b00100010001100001010101010101010; // this is an add instruction
initial clk = 0;
initial $display("fuuuuck me");
CPU cpu(clk,instruction, res, s0);
always #500 clk=!clk;
initial begin
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0); #500
$display("%b - %b", res,s0);
end
endmodule

module RegisterTest;
reg clk;
reg[4:0] ReadRegister1, ReadRegister2, WriteRegister;
reg RegWrite;
reg[31:0] WriteData;
wire[31:0] ReadData1, ReadData2, s0;

RegisterFile rfile(ReadData1,		// Contents of first register read
               ReadData2,		// Contents of second register read
               WriteData,		// Contents to write to register
               ReadRegister1,	// Address of first register to read 
               ReadRegister2,	// Address of second register to read
               WriteRegister,	// Address of register to write
               RegWrite,		// Enable writing of register when High
               clk,		// Clock (Positive Edge Triggered)
               s0);
initial clk=0;
always #500 clk=!clk;
initial begin
RegWrite = 0;
WriteRegister = 0;
WriteData = 0;
ReadRegister1 = 16;
ReadRegister2 = 00000;
#500 $display("%b", ReadData1);
$display("%b", s0);
#200
RegWrite = 1;
WriteRegister = 16;
WriteData = 2467;
#1800 $display("%b", ReadData1);
$display("%b", s0);
#1000 $display("%b", ReadData1);
$display("%b", s0);
end

endmodule
