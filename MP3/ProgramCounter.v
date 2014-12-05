
module ProgramCounter(clk,WrEn,DIn,Src,Imm16,Imm26,Out,Out4,Zero,ALUOp);

input clk;
input WrEn;
input [31:0] DIn;
input Src;
input [25:0] Imm26;
input [15:0] Imm16;
input Zero;
input[2:0] ALUOp;
output reg [31:0] Out;
output reg [31:0] Out4;

initial Out=0;

always @(posedge clk) begin
if(WrEn) Out=DIn;
else if(Zero&ALUOp[0]) begin Out = Out + Imm16<<2; $display("hifenfeoaefn"); end
else if(Src) Out=(Out&32'hf0000000)|(Imm26<<2);
else Out=Out+4;

Out4=Out+4;

end

endmodule

module TestProgramCounter;
reg clk;
reg WrEn;
reg Zero;
reg [31:0] DIn;
reg Src;
reg [31:0] Imm;
wire [31:0] Out;
ProgramCounter pc(clk,WrEn,DIn,Src,Imm,Out,Zero);
initial begin
clk<=0;
WrEn<=0;
Zero<=0;
Src<=0;
DIn<=0;
Imm<=0;
end
always #10 clk=1-clk;
initial begin
#85 Imm=5; Src=1;
$display("%b", Imm);
$display("%b", Imm<<2);
#10 Src=0;
#90 DIn=32; WrEn=1; Zero=1;
#10 WrEn=0;
end
endmodule
