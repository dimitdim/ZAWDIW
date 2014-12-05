module InstructionDecoder(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc, Bananna, regWE, Imm26);
input clk;
input[31:0] instruction;
output reg RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc, Bananna, regWE;
output reg[15:0] Imm16;
output reg[25:0] Imm26;
output reg[2:0] ALUOp;
output reg[4:0] Rt, Rs, Rd;

wire[5:0] opcode=instruction[31:26];

reg[4:0] shiftAmt;
reg[5:0] func;

initial begin
Bananna <= 0;
ALUSrc <= 0;
PCSrc <= 0;
PCWr <= 0;
DmWr <= 0;
MemOut <= 0;
RegDst <= 0;
RegWr <= 0;
ALUOp <= 0;
Rs <= 0;
Rt <= 0;
Rd <= 0;
shiftAmt <= 0;
func <= 0;
Imm16 <= 0;
regWE <=0;
Imm26 <= 0;
end

always @( * ) begin
if (opcode == 6'b000000) begin // if this is an R type instruction, do R type stuff
//same for all r-type
Bananna <= 0;
ALUSrc <= 0;
DmWr <= 0;
MemOut <= 0;
PCSrc <= 0;
Imm16 <= 0;
RegDst <= 0;
ALUOp <= 3'd0;
Rs <= instruction[25:21];
Rt <= instruction[20:16];
Rd <= instruction[15:11];

shiftAmt <= instruction[10:6];
func <= instruction[5:0];

if (func == 6'b001000) begin // jr
RegWr <= 0;
PCWr <= 1;
end else begin // add or addu
RegWr <= 1;
PCWr <= 0;
end // if (func == 6'b001000)

end // if (opcode == 6'b000000)
else if (opcode == 6'b001000 | opcode == 6'b001001) begin // addi or addiu
Bananna <= 0;
ALUSrc <= 1;
PCSrc <= 0;
PCWr <= 0;
DmWr <= 0;
MemOut <= 0;
RegDst <= 1;
RegWr <= 1;
ALUOp <= 3'd0;

Rs <= instruction[25:21];
Rt <= instruction[20:16];
Imm16 <= instruction[15:0];
Rd <= 0;
shiftAmt <= 0;
func <= 0;
end // if opcode == addi
else if (opcode == 6'b101011) begin // sw
Bananna <= 0;
ALUSrc <= 1;
PCSrc <= 0;
PCWr <= 0;
DmWr <= 1;
MemOut <= 0;
RegDst <= 0;
RegWr <= 0;
ALUOp <= 3'd0;

Rs <= instruction[25:21];
Rt <= instruction[20:16];
Imm16 <= instruction[15:0];
Rd <= 0;

shiftAmt <= 0;
func <= 0;
end // if (opcode == 6'b101011)
else if (opcode == 6'b100011) begin // lw
Bananna <= 0;
ALUSrc <= 1;
PCSrc <= 0;
PCWr <= 0;
DmWr <= 0;
MemOut <= 1;
RegDst <= 1;
RegWr <= 1;
ALUOp <= 3'd0;

Rs <= instruction[25:21];
Rt <= instruction[20:16];
Imm16 <= instruction[15:0];
Rd <= 0;

shiftAmt <= 0;
func <= 0;
end // if (opcode == 6'b100011)
else if (opcode == 6'b100011) begin // beq
Bananna <= 0;
ALUSrc <= 0;
PCSrc <= 0;
PCWr <= 0;
DmWr <= 0;
MemOut <= 0;
RegDst <= 0;
RegWr <= 0;
ALUOp <= 3'd1;

Rs <= instruction[25:21];
Rt <= instruction[20:16];
Imm16 <= instruction[15:0];
Rd <= 0;

shiftAmt <= 0;
func <= 0;
end // if (opcode == 6'b100011) 
else if (opcode == 6'b000010) begin // j
Bananna <= 0;
ALUSrc <= 0;
PCSrc <= 1;
PCWr <= 0;
DmWr <= 0;
MemOut <= 0;
RegDst <= 0;
RegWr <= 0;
ALUOp <= 3'd0;

Rs <= 0;
Rt <= 0;
Imm16 <= 0;
Rd <= 0;

shiftAmt <= 0;
func <= 0;
Imm26 <= instruction[25:0];
end // if (opcode == 6'b000010)
else if (opcode == 6'b000011) begin // jal
Imm26 <= instruction[25:0];

Bananna <= 1;
ALUSrc <= 0;
PCSrc <= 1;
PCWr <= 0;
DmWr <= 0;
MemOut <= 0;
RegDst <= 1;
RegWr <= 1;
ALUOp <= 3'd0;
Rs <= 0;
Rt <= 5'b11111;
Imm16 <= 0;
Rd <= 0;
shiftAmt <= 0;
func <= 0;
end // if (opcode == 6'b000011)
end // always @( * )

endmodule

module TestInstructionDecoder;
reg clk;
//reg[31:0] instruction = 32'b00100010000100001010101010101010;
reg[31:0] instruction = 32'b00000011111000001000100000100000;

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc, Bananna;
wire[15:0] Imm16;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd;

InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc, Bananna);
initial clk = 0;
always #500 clk=!clk; 

endmodule
