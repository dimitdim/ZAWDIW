module InstructionDecoder(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc);
input clk;
input[31:0] instruction;

output reg RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc;
output reg[15:0] Imm16;
output reg[2:0] ALUOp;
output reg[4:0] Rt, Rs, Rd;

wire[5:0] opcode = instruction[5:0];

reg[4:0] shiftAmt;
reg[5:0] func;

always @(posedge clk) begin
// if this is an R type instruction, do R type stuff
if (opcode == 0) begin
ALUSrc = 0;
PCSrc = 0;
PCWr = 0;
DmWr = 0;
MemOut = 0;
RegDst = 0;
RegWr = 1;

Rs = instruction[10:6];
Rt = instruction[15:11];
Rd = instruction[20:16];
shiftAmt = instruction[25:21];
func = instruction[31:26];

// If func is add, ALU Op is add
if (func == 6'b100000) begin
ALUOp = 3'd0;
// Else subtract
end else begin
ALUOp = 3'd1;
end // if func == add

end // if opcode == 0
end // always @(posedge clk)

endmodule

module TestInstructionDecoder;
reg clk;
reg[31:0] instruction = 32'b00000011111000001000100000100000;

wire RegWr, PCWr, MemOut, ALUSrc, DmWr, RegDst, PCSrc;
wire[15:0] Imm16;
wire[2:0] ALUOp;
wire[4:0] Rt, Rs, Rd;

InstructionDecoder id(clk, instruction, RegWr, PCWr, MemOut, ALUSrc, DmWr, Rt, Rs, Rd, RegDst, Imm16, ALUOp, PCSrc);
initial clk = 0;
always #500 clk=!clk; 

endmodule