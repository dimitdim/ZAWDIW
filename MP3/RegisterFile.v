module register32(q, d, wrenable, clk, num);
input[4:0] num;
input[31:0]	d;
input	wrenable;
input	clk;
output reg[31:0] q;
initial q[31:0] = 0;
always @(posedge clk) begin
    if(wrenable) begin
	$display($time, ": %d: %d -> %d",num,q,d);
	if(num) q = d;
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
               Clk,		// Clock (Positive Edge Triggered)
               s0);
output[31:0]	ReadData1;
output[31:0]	ReadData2;
input[31:0]	WriteData;
input[4:0]	ReadRegister1;
input[4:0]	ReadRegister2;
input[4:0]	WriteRegister;
input		RegWrite;
input		Clk;
input[31:0]	s0;
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
register32 Reg0(input0,WriteData,RegEn[0],Clk,5'd1);
register32 Reg1(input1,WriteData,RegEn[1],Clk,5'd1);
register32 Reg2(input2,WriteData,RegEn[2],Clk,5'd2);
register32 Reg3(input3,WriteData,RegEn[3],Clk,5'd3);
register32 Reg4(input4,WriteData,RegEn[4],Clk,5'd4);
register32 Reg5(input5,WriteData,RegEn[5],Clk,5'd5);
register32 Reg6(input6,WriteData,RegEn[6],Clk,5'd6);
register32 Reg7(input7,WriteData,RegEn[7],Clk,5'd7);
register32 Reg8(input8,WriteData,RegEn[8],Clk,5'd8);
register32 Reg9(input9,WriteData,RegEn[9],Clk,5'd9);
register32 Reg10(input10,WriteData,RegEn[10],Clk,5'd10);
register32 Reg11(input11,WriteData,RegEn[11],Clk,5'd11);
register32 Reg12(input12,WriteData,RegEn[12],Clk,5'd12);
register32 Reg13(input13,WriteData,RegEn[13],Clk,5'd13);
register32 Reg14(input14,WriteData,RegEn[14],Clk,5'd14);
register32 Reg15(input15,WriteData,RegEn[15],Clk,5'd15);
register32 Reg16(input16,WriteData,RegEn[16],Clk,5'd16);
register32 Reg17(input17,WriteData,RegEn[17],Clk,5'd17);
register32 Reg18(input18,WriteData,RegEn[18],Clk,5'd18);
register32 Reg19(input19,WriteData,RegEn[19],Clk,5'd19);
register32 Reg20(input20,WriteData,RegEn[20],Clk,5'd20);
register32 Reg21(input21,WriteData,RegEn[21],Clk,5'd21);
register32 Reg22(input22,WriteData,RegEn[22],Clk,5'd22);
register32 Reg23(input23,WriteData,RegEn[23],Clk,5'd23);
register32 Reg24(input24,WriteData,RegEn[24],Clk,5'd24);
register32 Reg25(input25,WriteData,RegEn[25],Clk,5'd25);
register32 Reg26(input26,WriteData,RegEn[26],Clk,5'd26);
register32 Reg27(input27,WriteData,RegEn[27],Clk,5'd27);
register32 Reg28(input28,WriteData,RegEn[28],Clk,5'd28);
register32 Reg29(input29,WriteData,RegEn[29],Clk,5'd29);
register32 Reg30(input30,WriteData,RegEn[30],Clk,5'd30);
register32 Reg31(input31,WriteData,RegEn[31],Clk,5'd31);
assign s0 = input16;
mux32to1by32 Mux1(ReadData1, ReadRegister1, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
mux32to1by32 Mux2(ReadData2, ReadRegister2, input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31);
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
