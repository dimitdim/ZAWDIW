module SignExtend(in, in26, out, sign, clk);
input[15:0] in;
input[25:0] in26;
input sign, clk;
output reg[31:0] out;
initial out=32'd0;
always @( * ) begin
if(in26) out={6'b000000,in26[25:0]};
else begin
if(sign & in[15]) out={16'b111111111111111,in[15:0]};
else out={16'b0000000000000000,in[15:0]};
end
end
endmodule

module mux32to1by2(out, addressinput, input0, input1);
input[31:0] input0, input1;
input addressinput;
output[31:0] out;
wire[31:0] mux[1:0];
assign mux[0] = input0;
assign mux[1] = input1;
assign out=mux[addressinput];
endmodule

module mux5to1by2(out, addressinput, input0, input1);
input[4:0] input0, input1;
input addressinput;
output[4:0] out;
wire[4:0] mux[1:0];
assign mux[0] = input0;
assign mux[1] = input1;
assign out=mux[addressinput];
endmodule

module memory(clk, regWE, Addr, DataIn, DataOut);
input clk, regWE;
input[9:0] Addr;
input[31:0] DataIn;
output[31:0] DataOut;
reg [31:0] mem[1023:0];
always @(posedge clk) if (regWE) mem[Addr] <= DataIn;
initial $readmemh("code1.dat", mem);
assign DataOut = mem[Addr/4];
endmodule