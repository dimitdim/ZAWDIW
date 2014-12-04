// Variables for ALU commands.
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

// FullAdder1bit
// Defines a 1-bit full adder
module FullAdder1bit(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;

wire AxorB;
wire AandB;
wire AxorBandC;

xor xor0(AxorB, a, b);
and and0(AandB, a, b);
and and1(AxorBandC, AxorB, carryin);

xor xor1(out, AxorB, carryin);
or or0(carryout, AxorBandC, AandB);

endmodule

// ALUcontrolLUT
// Defines the lookup table telling the ALU what operation to do.
module ALUcontrolLUT(muxindex, invertB, ALUcommand);

output reg[1:0] muxindex;
output reg      invertB;

input[2:0]      ALUcommand;

always @(ALUcommand) begin
	case (ALUcommand)
	`ADD:  begin muxindex=0; invertB=0; end
	`SUB:  begin muxindex=0; invertB=1; end
	`XOR:  begin muxindex=1; invertB=0; end
	`SLT:  begin muxindex=1; invertB=1; end
	`AND:  begin muxindex=2; invertB=0; end
	`NAND: begin muxindex=2; invertB=1; end
	`NOR:  begin muxindex=3; invertB=1; end
	`OR:   begin muxindex=3; invertB=0; end
	endcase
end

endmodule

// ALU_slice
// Defines a single bit slice
module ALU_slice(out,carryout,A,B,carryin,index,invert);
output out,carryout;
input A,B,carryin,invert;
input[1:0] index;
wire newB,AanewB,AxnewB,out0,CAndY,over,SLT;
not (ninvert,invert);
 
xor BXor (newB,invert,B);
and InAnd (AanewB,A,newB);
xor InXor (AxnewB,A,newB);
xor OutXor (out0,carryin,AxnewB);
and CAnd (CAndY,carryin,AxnewB);
or OutOr (carryout,CAndY,AanewB);
 
xor ABXor (AxB,A,B);
xor Xover (over,carryin,carryout);
xor XSTL (SLT,over,out0);
and (out1a,ninvert,AxB);
and (out1b,invert,SLT);
or (out1,out1a,out1b);
 
and ABAnd (AaB,A,B);
xor ABAndX (out2,AaB,invert);
 
or ABOr (AoB,A,B);
xor ABOrX (out3,AoB,invert);
 
MUX mux (out,index[1],index[0],out0,out1,out2,out3);
 
endmodule
 
// MUX
// Defines the mux for selecting an operation from a bit slice
module MUX(out, address1,address0, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire ns0,ns1,si0,si1,si2,si3,ai0,ai1,ai2,ai3;
not (ns0,address0);
not (ns1,address1);
 
and (si0,ns0,ns1);
and (si1,address0,ns1);
and (si2,ns0,address1);
and (si3,address0,address1);
and (ai0,si0,in0);
and (ai1,si1,in1);
and (ai2,si2,in2);
and (ai3,si3,in3);
or (out,ai0,ai1,ai2,ai3);
endmodule

// ALU
// Defines the actual ALU.
module ALU(result, carryout, zero, overflow, operandA, operandB, command);

output[31:0]  result;
output        carryout;
output        zero;
output        overflow;

input[31:0]   operandA;
input[31:0]   operandB;
input[2:0]    command;

// LUT stuff -----------------------------------|
wire[1:0] muxindex;
wire invertB;
ALUcontrolLUT lut(muxindex, invertB, command);

// Define carry-related things ------|
wire[32:0] carry; // carry chain is 1 bit wider to make the loop work
buf setcarry0 (carry[0], invertB);

// Do all the bitwise operations ---------------|
genvar i;
generate
	for (i=0; i<32; i=i+1) begin : alu_loop
		ALU_slice aluslice(result[i],carry[i+1],operandA[i],operandB[i],carry[i],muxindex,invertB);
	end
endgenerate

// This part is for finding the overflow and carryout and zero -------|
xor carries(overflow_temp, carry[31], carry[32]);
nand add_or_sub(addsub,muxindex[0],muxindex[1]);
and carries2(overflow,overflow_temp,addsub);
buf setcarryout (carryout, carry[32]);
//nor (zero, result[31:0]);
assign zero = ~|result;

endmodule


// test_ALU
// Tests each operation of the ALU
module test_ALU;
reg [31:0] operandA;
reg [31:0] operandB;
reg [2:0] command;
wire [31:0] result;
wire carryout;
wire overflow;
wire zero;
parameter del = 1000;
ALU alu (result, carryout, zero, overflow, operandA, operandB, command);

initial begin
$display("<-------------------------------------------------32-bit ALU----------------------------------------------->");
$display("<-------------------------------------------------Test ADD------------------------------------------------->");
command=`ADD;

operandA=100; operandB=100; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing small numbers -- should have no carryout or overflow");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("00000000000000000000000011001000  ||    0     ||  0");

operandA=1073741824; operandB=1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing (2^31)/2 + (2^31)/2 -- should have overflow and no carryout and equal -(2^31)");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("10000000000000000000000000000000  ||    0     ||  1");

operandA=-1073741824; operandB=-1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing -(2^31)/2 + -(2^31)/2 -- should have carryout and no overflow and equal -(2^31)");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("10000000000000000000000000000000  ||    1     ||  0");

operandA=-2147483647; operandB=-1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing -(2^31)-1 + -2^30 -- should have overflow and carryout");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("01000000000000000000000000000001  ||  1  || 1");

operandA=3429324; operandB=-3429324; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing that some random number I typed plus its inverse is 0");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("00000000000000000000000000000000  ||    1     || 0");

$display("<-------------------------------------------------Test SUB------------------------------------------------->");
command=`SUB;

operandA=100; operandB=-100; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing small numbers -- should have no carryout or overflow");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("00000000000000000000000011001000  ||    0     ||  0");

operandA=1073741824; operandB=-1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing (2^31)/2 - -(2^31)/2 -- should have overflow and no carryout and equal -(2^31)");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("10000000000000000000000000000000  ||    0     ||  1");

operandA=-1073741824; operandB=1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing -(2^31)/2 - (2^31)/2 -- should have carryout and no overflow and equal -(2^31)");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("10000000000000000000000000000000  ||    1     ||  0");

operandA=-2147483647; operandB=1073741824; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing -(2^31)-1 - 2^30 -- should have overflow and carryout");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("01000000000000000000000000000001  ||    1     ||  1");

operandA=3429324; operandB=3429324; #del
$display("<---------------------------------------------------------------------------------------------------------->");
$display("Testing that some random number I typed minus itself is 0");
$display("Operands (A || B)");
$display("%b  ||  %b", operandA, operandB);
$display("-----------------------------------------------------------");
$display("Actual results:      result       || carryout || overflow");
$display("%b  ||    %b     ||  %b", result, carryout, overflow);
$display("Expected results:    result       || carryout || overflow");
$display("00000000000000000000000000000000  ||    1     ||  0");

command=`SLT;
$display("<-------------------------------------------------Test SLT------------------------------------------------->");
$display("Test Bench for SLT. Carryout and Overflow always false");
$display("                 A                    |                  B                   |                 Output                |  Zero  |  Expected ");
operandA=2; operandB=1; #del
$display("   %b   |   %b   |   %b    |   %b    |  0  0",operandA,operandB,result,zero);
operandA=1; operandB=2; #del
$display("   %b   |   %b   |   %b    |   %b    |  1  0",operandA,operandB,result,zero);
operandA=1; operandB=1; #del
$display("   %b   |   %b   |   %b    |   %b    |  0  1",operandA,operandB,result,zero);


$display("<------------------------------------------Test Boolean operations----------------------------------------->");
$display("Command  | A                                 B                                | Result                            Overflow Carryout Zero | Expected Output");
operandA=1431655765;operandB=16733610;command=`AND; #del 
$display("%b AND  | %b  %b | %b  %b        %b        %b    | 00000000010101010101010100000000",  command, operandA, operandB, result, overflow, carryout, zero);
operandA=1431655765;operandB=16733610;command=`NAND; #del 
$display("%b NAND | %b  %b | %b  %b        %b        %b    | 11111111101010101010101011111111",  command, operandA, operandB, result, overflow, carryout, zero);
operandA=1431655765;operandB=16733610;command=`NOR; #del 
$display("%b NOR  | %b  %b | %b  %b        %b        %b    | 10101010000000001010101000000000",  command, operandA, operandB, result, overflow, carryout, zero);
operandA=1431655765;operandB=16733610;command=`OR; #del 
$display("%b OR   | %b  %b | %b  %b        %b        %b    | 01010101111111110101010111111111",  command, operandA, operandB, result, overflow, carryout, zero);
operandA=1431655765;operandB=16733610;command=`XOR; #del 
$display("%b XOR  | %b  %b | %b  %b        %b        %b    | 01010101101010100000000011111111",  command, operandA, operandB, result, overflow, carryout, zero);

//$display("Command  | A                                 B                                | Result                            Overflow Carryout Zero | Expected Output");
//$display("100 XOR  | 01010101101010100000000011111111  01010101101010100000000011111111 | 01010101101010100000000011111111  0        0        0    | 01010101101010100000000011111111",  command, operandA, operandB, result, overflow, carryout, zero);


end
endmodule

