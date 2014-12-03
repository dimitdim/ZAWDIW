module InstructionDecoder(instruction, a);
input[0:31] instruction;
output reg a = 0;

wire[0:4] opcode = instruction[0:4];

initial begin
$display("%b", opcode);
$display("%b", instruction[0:4]);
if (opcode == 0) begin
$display("hello");
a = 1;
end else begin
a = 0;
end
end

endmodule


module TestInstructionDecoder;
reg[0:31] instruction = 65;
wire a;
InstructionDecoder id(instruction, a);
initial begin
$display("%b", instruction);
$display("%b", a);
end
endmodule
