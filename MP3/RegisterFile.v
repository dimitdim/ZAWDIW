module register(q, d, wrenable, clk);
input	d;
input	wrenable;
input	clk;
output reg q;

always @(posedge clk) begin
    if(wrenable) begin
	q = d;
    end
end
endmodule

module register32(q, d, wrenable, clk);
input[31:0]	d;
input	wrenable;
input	clk;
output reg[31:0] q;

always @(posedge clk) begin
    if(wrenable) begin
	q = d;
    end
end
endmodule

module register32zero(q, d, wrenable, clk);
input[31:0]	d;
input	wrenable;
input	clk;
output reg[31:0] q;

always @(posedge clk) begin
    if(wrenable) begin
	q[31:0] = 0;
    end
end
endmodule

module mux32to1by1(out, address, inputs);
input[31:0] inputs;
input[4:0] address;
output out;

assign out=inputs[address];
endmodule

module mux32to1by32(out, addressinput, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
input[31:0] input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31;
input[4:0] addressinput;
output[31:0] out;

wire[31:0] mux[31:0];
assign mux[0] = input0;
assign mux[1] = input1;
assign mux[2] = input2;
assign mux[3] = input3;
assign mux[4] = input4;
assign mux[5] = input5;
assign mux[6] = input6;
assign mux[7] = input7;
assign mux[8] = input8;
assign mux[9] = input9;
assign mux[10] = input10;
assign mux[11] = input11;
assign mux[12] = input12;
assign mux[13] = input13;
assign mux[14] = input14;
assign mux[15] = input15;
assign mux[16] = input16;
assign mux[17] = input17;
assign mux[18] = input18;
assign mux[19] = input19;
assign mux[20] = input20;
assign mux[21] = input21;
assign mux[22] = input22;
assign mux[23] = input23;
assign mux[24] = input24;
assign mux[25] = input25;
assign mux[26] = input26;
assign mux[27] = input27;
assign mux[28] = input28;
assign mux[29] = input29;
assign mux[30] = input30;
assign mux[31] = input31;

assign out=mux[addressinput];
endmodule

module decoder1to32(out, enable, address);
output[31:0] out;
input enable;
input[4:0] address;

assign out = enable<<address;
endmodule

module RegisterFile(ReadData1,		// Contents of first register read
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
wire[31:0] RegEn;
wire[31:0] input0;
wire[31:0] input1;
wire[31:0] input2;
wire[31:0] input3;
wire[31:0] input4;
wire[31:0] input5;
wire[31:0] input6;
wire[31:0] input7;
wire[31:0] input8;
wire[31:0] input9;
wire[31:0] input10;
wire[31:0] input11;
wire[31:0] input12;
wire[31:0] input13;
wire[31:0] input14;
wire[31:0] input15;
wire[31:0] input16;
wire[31:0] input17;
wire[31:0] input18;
wire[31:0] input19;
wire[31:0] input20;
wire[31:0] input21;
wire[31:0] input22;
wire[31:0] input23;
wire[31:0] input24;
wire[31:0] input25;
wire[31:0] input26;
wire[31:0] input27;
wire[31:0] input28;
wire[31:0] input29;
wire[31:0] input30;
wire[31:0] input31;
decoder1to32 Dec(RegEn,RegWrite,WriteRegister);
register32zero Reg0(input0,WriteData,RegEn[0],Clk);
register32 Reg1(input1,WriteData,RegEn[1],Clk);
register32 Reg2(input2,WriteData,RegEn[2],Clk);
register32 Reg3(input3,WriteData,RegEn[3],Clk);
register32 Reg4(input4,WriteData,RegEn[4],Clk);
register32 Reg5(input5,WriteData,RegEn[5],Clk);
register32 Reg6(input6,WriteData,RegEn[6],Clk);
register32 Reg7(input7,WriteData,RegEn[7],Clk);
register32 Reg8(input8,WriteData,RegEn[8],Clk);
register32 Reg9(input9,WriteData,RegEn[9],Clk);
register32 Reg10(input10,WriteData,RegEn[10],Clk);
register32 Reg11(input11,WriteData,RegEn[11],Clk);
register32 Reg12(input12,WriteData,RegEn[12],Clk);
register32 Reg13(input13,WriteData,RegEn[13],Clk);
register32 Reg14(input14,WriteData,RegEn[14],Clk);
register32 Reg15(input15,WriteData,RegEn[15],Clk);
register32 Reg16(input16,WriteData,RegEn[16],Clk);
register32 Reg17(input17,WriteData,RegEn[17],Clk);
register32 Reg18(input18,WriteData,RegEn[18],Clk);
register32 Reg19(input19,WriteData,RegEn[19],Clk);
register32 Reg20(input20,WriteData,RegEn[20],Clk);
register32 Reg21(input21,WriteData,RegEn[21],Clk);
register32 Reg22(input22,WriteData,RegEn[22],Clk);
register32 Reg23(input23,WriteData,RegEn[23],Clk);
register32 Reg24(input24,WriteData,RegEn[24],Clk);
register32 Reg25(input25,WriteData,RegEn[25],Clk);
register32 Reg26(input26,WriteData,RegEn[26],Clk);
register32 Reg27(input27,WriteData,RegEn[27],Clk);
register32 Reg28(input28,WriteData,RegEn[28],Clk);
register32 Reg29(input29,WriteData,RegEn[29],Clk);
register32 Reg30(input30,WriteData,RegEn[30],Clk);
register32 Reg31(input31,WriteData,RegEn[31],Clk);
mux32to1by32 Mux1(ReadData1, ReadRegister1, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
mux32to1by32 Mux2(ReadData2, ReadRegister2, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
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
$display(dutpassed);
end

endmodule

// This is your actual test bench.
// It generates the signals to drive a registerfile and passes it back up one layer to the harness
//	((This lets us plug in various working / broken registerfiles to test
// When begintest is asserted, begin testing the register file.
// When your test is conclusive, set dutpassed as appropriate and then raise endtest.
module hw4testbench(begintest, endtest, dutpassed,
		    ReadData1,ReadData2,WriteData, ReadRegister1, ReadRegister2,WriteRegister,RegWrite, Clk);
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

// Test Case 1: Write to 42 register 2, verify with Read Ports 1 and 2
// This will pass because the example register file is hardwired to always return 42.
WriteRegister = 2;
WriteData = 42;
RegWrite = 1;
ReadRegister1 = 2;
ReadRegister2 = 2;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
if(ReadData1 != 42 || ReadData2!= 42) begin
	dutpassed = 0;
	$display("Test Case 1 Failed");
end

// Test Case 2: Write to 15 register 2, verify with Read Ports 1 and 2
// This will fail with the example register file, but should pass with yours.
WriteRegister = 2;
WriteData = 15;
RegWrite = 1;
ReadRegister1 = 2;
ReadRegister2 = 2;
#5 Clk=1; #5 Clk=0;
if(ReadData1 != 15 || ReadData2!= 15) begin
	dutpassed = 0;	// On Failure, set to false.
	$display("Test Case 2 Failed");
	end

// Test Case 3: Write to 42 register 3, but don't enable, verify with Read Ports 1 and 2
WriteRegister = 3;
WriteData = 42;
RegWrite = 0;
ReadRegister1 = 3;
ReadRegister2 = 3;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
if(ReadData1 == 42 || ReadData2 == 42) begin
	dutpassed = 0;
	$display("Write Enable is broken/ignored - Register is always written to");
end

// Test Case 4: Write to 42 register 4, verify register 5 is still 0 with Read Ports 1 and 2
WriteRegister = 4;
WriteData = 42;
RegWrite = 1;
ReadRegister1 = 5;
ReadRegister2 = 5;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
if(ReadData1 == 42 || ReadData2 == 42) begin
	dutpassed = 0;
	$display("Decoder is broken - All registers are written to");
end


// Test Case 5: Write to 42 register 0, verify it's still 0 with Read Ports 1 and 2
WriteRegister = 0;
WriteData = 42;
RegWrite = 1;
ReadRegister1 = 0;
ReadRegister2 = 0;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
if(ReadData1 != 0 || ReadData2 != 0) begin
	dutpassed = 0;
	$display("Register Zero is acutally a register instead of the constant value zero");
end


// Test Case 6: Write to 42 register 2, verify with Read Ports 1 and 2
WriteRegister = 2;
WriteData = 42;
RegWrite = 1;
ReadRegister1 = 2;
ReadRegister2 = 2;
#5 Clk=1; #5 Clk=0;	// Generate Clock Edge
if(ReadData1 == 17 || ReadData2 == 17) begin
	dutpassed = 0;
	$display("Port 2 is broken and always reads register 17");
end

if(dutpassed == 1) begin
$display("Congratulations! Your refile is perfect!");
end
//We're done!  Wait a moment and signal completion.
#5
endtest = 1;
end

endmodule
