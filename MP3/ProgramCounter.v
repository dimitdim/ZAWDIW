module ProgramCounter(clk,WrEn,DIn,Src,Imm,Out,Zero);
input clk;
input WrEn;
input [31:0] DIn;
input Src;
input [31:0] Imm;
input Zero;
output reg [31:0] Out;

initial Out=0;

always @(posedge clk) begin
Out=Out+4;
if(Src) Out=Out+(Imm<<2);
if(WrEn & Zero) Out=DIn;
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