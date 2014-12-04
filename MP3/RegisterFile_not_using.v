module decoder1to32(out, enable, address);
output[31:0]	out;
input		enable;
input[4:0]	address;

wire[31:0] out;

assign out = enable<<address; 
endmodule

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
input	d[31:0];
input	wrenable;
input	clk;
output reg q[31:0];

always @(posedge clk) begin
    if(wrenable) begin
	q[31:0] = d[31:0];
    end
end
endmodule

module register32zero(q[31:0], d[31:0], wrenable, clk);
input	d[31:0];
input	wrenable;
input	clk;
output reg q[31:0];

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

wire mux;
assign mux=inputs;
assign out=mux[address];
endmodule

module mux32to1by32(out, addressinput, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
input[31:0] input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31;
input[4:0] address;
output out;

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

assign out=mux[address];
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

endmodule
