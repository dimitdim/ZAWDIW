// Hey yo, deliverable 1 is a D flip flop with a mux where output goes to D and one of the inputs is Q (the DFF output)
// Also, in Verilog, X is equal to everything (watch out for this in your test bench)
// Deliverable 7 - your register file gets put through Eric's test bench

`include "decoders.v"
`include "muxes.v"
`include "register.v"

module regfile(ReadData1,		// Contents of first register read
               ReadData2,		// Contents of second register read
               WriteData,		// Contents to write to register
               ReadRegister1,	// Address of first register to read 
               ReadRegister2,	// Address of second register to read
               WriteRegister,	// Address of register to write
               RegWrite,		// Enable writing of register when High
               Clk);		// Clock (Positive Edge Triggered)

output[31:0]	ReadData1;
output[31:0]	ReadData2;
input[31:0]	WriteData;
input[4:0]	ReadRegister1;
input[4:0]	ReadRegister2;
input[4:0]	WriteRegister;
input		RegWrite;
input		Clk;

// decoder
wire[31:0] decoderOutput;
decoder1to32 decoder(decoderOutput, RegWrite, WriteRegister);

// zero register
wire[31:0] regOut[31:0]; // gets turned into a 2d array, we'll see how that goes
register32zero reg0(regOut[0], WriteData, decoderOutput[0], Clk); // set zero register

// all the other f***ing registers
register32 reg1(regOut[1], WriteData, decoderOutput[1], Clk);
register32 reg2(regOut[2], WriteData, decoderOutput[2], Clk);
register32 reg3(regOut[3], WriteData, decoderOutput[3], Clk);
register32 reg4(regOut[4], WriteData, decoderOutput[4], Clk);
register32 reg5(regOut[5], WriteData, decoderOutput[5], Clk);
register32 reg6(regOut[6], WriteData, decoderOutput[6], Clk);
register32 reg7(regOut[7], WriteData, decoderOutput[7], Clk);
register32 reg8(regOut[8], WriteData, decoderOutput[8], Clk);
register32 reg9(regOut[9], WriteData, decoderOutput[9], Clk);
register32 reg10(regOut[10], WriteData, decoderOutput[10], Clk);
register32 reg11(regOut[11], WriteData, decoderOutput[11], Clk);
register32 reg12(regOut[12], WriteData, decoderOutput[12], Clk);
register32 reg13(regOut[13], WriteData, decoderOutput[13], Clk);
register32 reg14(regOut[14], WriteData, decoderOutput[14], Clk);
register32 reg15(regOut[15], WriteData, decoderOutput[15], Clk);
register32 reg16(regOut[16], WriteData, decoderOutput[16], Clk);
register32 reg17(regOut[17], WriteData, decoderOutput[17], Clk);
register32 reg18(regOut[18], WriteData, decoderOutput[18], Clk);
register32 reg19(regOut[19], WriteData, decoderOutput[19], Clk);
register32 reg20(regOut[20], WriteData, decoderOutput[20], Clk);
register32 reg21(regOut[21], WriteData, decoderOutput[21], Clk);
register32 reg22(regOut[22], WriteData, decoderOutput[22], Clk);
register32 reg23(regOut[23], WriteData, decoderOutput[23], Clk);
register32 reg24(regOut[24], WriteData, decoderOutput[24], Clk);
register32 reg25(regOut[25], WriteData, decoderOutput[25], Clk);
register32 reg26(regOut[26], WriteData, decoderOutput[26], Clk);
register32 reg27(regOut[27], WriteData, decoderOutput[27], Clk);
register32 reg28(regOut[28], WriteData, decoderOutput[28], Clk);
register32 reg29(regOut[29], WriteData, decoderOutput[29], Clk);
register32 reg30(regOut[30], WriteData, decoderOutput[30], Clk);
register32 reg31(regOut[31], WriteData, decoderOutput[31], Clk);

// the two muxes
mux32to1by32 mux1(ReadData1, ReadRegister1, regOut[0], regOut[1], regOut[2], regOut[3], regOut[4], regOut[5], regOut[6], regOut[7], regOut[8], regOut[9],
                    regOut[10], regOut[11], regOut[12], regOut[13], regOut[14], regOut[15], regOut[16], regOut[17], regOut[18], regOut[19], regOut[20],
                    regOut[21], regOut[22], regOut[23], regOut[24], regOut[25], regOut[26], regOut[27], regOut[28], regOut[29], regOut[30], regOut[31]);
mux32to1by32 mux2(ReadData2, ReadRegister2, regOut[0], regOut[1], regOut[2], regOut[3], regOut[4], regOut[5], regOut[6], regOut[7], regOut[8], regOut[9],
                    regOut[10], regOut[11], regOut[12], regOut[13], regOut[14], regOut[15], regOut[16], regOut[17], regOut[18], regOut[19], regOut[20],
                    regOut[21], regOut[22], regOut[23], regOut[24], regOut[25], regOut[26], regOut[27], regOut[28], regOut[29], regOut[30], regOut[31]);

// I really wanted this to work :( -----------------------------------------------
//genvar i;
//generate
//	for (i=1; i<32; i=i+1) begin : registers
//		register32 reg32(regOut[i], WriteData, decoderOutput[i], Clk); // set other registers
//	end
//endgenerate
//
//mux32to1by32_better bettermux1(ReadData1, ReadRegister1, regOut);
//mux32to1by32_better bettermux2(ReadData2, ReadRegister2, regOut);

endmodule

// Validates your hw4testbench by connecting it to various functional 
// or broken register files and verifying that it correctly identifies 
module hw4testbenchharness;
wire[31:0]	ReadData1;
wire[31:0]	ReadData2;
wire[31:0]	WriteData;
wire[4:0]	ReadRegister1;
wire[4:0]	ReadRegister2;
wire[4:0]	WriteRegister;
wire		RegWrite;
wire		Clk;
reg		begintest;

// The register file being tested.  DUT = Device Under Test
regfile DUT(ReadData1,ReadData2,WriteData, ReadRegister1, ReadRegister2,WriteRegister,RegWrite, Clk);

// The test harness to test the DUT
hw4testbench tester(begintest, endtest, dutpassed,ReadData1,ReadData2,WriteData, ReadRegister1, ReadRegister2,WriteRegister,RegWrite, Clk);


initial begin
begintest=0;
#10;
begintest=1;
#1000;
end

always @(posedge endtest) begin
$display("-------------------------------------------------------------------------------------------------------------------");
$display("DUT passed?  ", dutpassed);
if(dutpassed==1) begin
$display("All tests passed! This register file is mad decent.");
end
end

endmodule

// This is your actual test bench.
// It generates the signals to drive a registerfile and passes it back up one layer to the harness
//	((This lets us plug in various working / broken registerfiles to test
// When begintest is asserted, begin testing the register file.
// When your test is conclusive, set dutpassed as appropriate and then raise endtest.
module hw4testbench(begintest, endtest, dutpassed,
		    ReadData1,ReadData2,WriteData, 
                    ReadRegister1, ReadRegister2,WriteRegister,
                    RegWrite, Clk);
output reg endtest;
output reg dutpassed;
input	   begintest;

input[31:0]		ReadData1;
input[31:0]		ReadData2;
output reg[31:0]	WriteData;
output reg[4:0]		ReadRegister1;
output reg[4:0]		ReadRegister2;
output reg[4:0]		WriteRegister;
output reg		RegWrite;
output reg		Clk;

initial begin
WriteData=0;
ReadRegister1=0;
ReadRegister2=0;
WriteRegister=0;
RegWrite=0;
Clk=0;
end

always @(posedge begintest) begin
endtest = 0;
dutpassed = 1;
#10

$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 1: Write to 42 register 2, verify with Read Ports 1 and 2");
$display("This will pass because this register file is flawless.");
WriteRegister = 2;
WriteData = 42;
RegWrite = 1;
ReadRegister1 = 2;
ReadRegister2 = 2;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
$display("-------------------------------------------------------------------------------------------------------------------");
$display("ReadData1 ||       actual: %d ||       expected: %d", ReadData1, WriteData);
$display("ReadData2 ||       actual: %d ||       expected: %d", ReadData2, WriteData);
if(ReadData1 != 42 || ReadData2!= 42) begin
	dutpassed = 0;
	$display("Test Case 1 Failed");
	end

$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 2: Write to 15 register 2, verify with Read Ports 1 and 2");
$display("This will fail with the example register file, but should pass with yours.");
WriteRegister = 2;
WriteData = 15;
RegWrite = 1;
ReadRegister1 = 2;
ReadRegister2 = 2;
#5 Clk=1; #5 Clk=0;
$display("ReadData1 ||       actual: %d ||       expected: %d", ReadData1, WriteData);
$display("ReadData2 ||       actual: %d ||       expected: %d", ReadData2, WriteData);
if(ReadData1 != 15 || ReadData2!= 15) begin
	dutpassed = 0;	// On Failure, set to false.
	$display("Test Case 2 Failed");
	end


$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 3: Test if write enable is broken by writing to register 4, turning enable off and writing to register 5.");
$display("This will fail if it can read something other than x from register 5.");
WriteRegister=4;
WriteData=26;
RegWrite=1;
ReadRegister1 = 4;
ReadRegister2 = 5;
#5 Clk=1; #5 Clk=0;
WriteRegister=5;
WriteData=27;
RegWrite=0;
ReadRegister1 = 4;
ReadRegister2 = 5;
#5 Clk=1; #5 Clk=0;
$display("ReadData1 ||       actual: %d ||       expected:         26", ReadData1);
$display("ReadData2 ||       actual: %d ||       expected:         x", ReadData2);
if (ReadData1 == WriteData || ReadData2 == WriteData) begin
	dutpassed=0;
	$display("Test Case 3 Failed");
	end

$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 4: Test for broken decoder that writes to all registers by writing to reg 1 and reading reg 25.");
$display("This will fail if reg 25 equals the write data.");
WriteRegister=1;
WriteData=59;
RegWrite=1;
ReadRegister1 = 1;
ReadRegister2 = 25;
#5 Clk=1; #5 Clk=0;
$display("ReadData1 ||       actual: %d ||       expected: %d", ReadData1, WriteData);
$display("ReadData2 ||       actual: %d ||       expected:         x", ReadData2);
if (ReadData2 == WriteData) begin
	dutpassed=0;
	$display("Test Case 4 Failed");
	end

$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 5: Test that the zero register is actually zero.");
$display("This will fail if something other than zero comes out of the zero register."); 
WriteRegister=0;
WriteData=59;
RegWrite=1;
ReadRegister1 = 0;
ReadRegister2 = 0;
#5 Clk=1; #5 Clk=0;
$display("ReadData1 ||       actual: %d ||       expected: %d", ReadData1, 0);
$display("ReadData2 ||       actual: %d ||       expected: %d", ReadData2, 0);
if (ReadData1 != 0 || ReadData2 != 0) begin
	dutpassed=0;
	$display("Test Case 5 Failed");
	end

$display("-------------------------------------------------------------------------------------------------------------------");
$display("Test Case 6: Test that port 2 doesn't always read register 17 by writing to reg 17 and reading reg 23 from port 2."); 
$display("This will fail if the ReadData2 is the same as WriteData. Hell, let's test ReadData1 while we're at it."); 
WriteRegister=17;
WriteData=59;
RegWrite=1;
ReadRegister1 = 8;
ReadRegister2 = 23;
#5 Clk=1; #5 Clk=0;
$display("ReadData2 ||       actual: %d ||       expected:         x", ReadData1);
$display("ReadData2 ||       actual: %d ||       expected:         x", ReadData2);
if (ReadData2 == WriteData) begin
	dutpassed=0;
	$display("Test Case 6 Failed");
	end

//We're done!  Wait a moment and signal completion.
#5
endtest = 1;
end

endmodule