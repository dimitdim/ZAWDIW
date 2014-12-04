module SignExtend(in, out, sign, clk);
input[15:0] in;
input sign, clk;
output reg[31:0] out;
always @(posedge clk) begin
if(sign & in[15]) out={16'b111111111111111,in[15:0]};
else out={16'b0000000000000000,in[15:0]};
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