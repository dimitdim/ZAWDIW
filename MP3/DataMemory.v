module DataMemory(clk, dataOut, address, writeEnable, dataIn);
parameter addresswidth = 32;
parameter depth = 100000;
parameter width = 32;

output reg [width-1:0]  dataOut;

input clk;
input [addresswidth-1:0]    address;
input writeEnable;
input[width-1:0]    dataIn;

reg [width-1:0] memory [depth-1:0];

always @(posedge clk) begin
    if(writeEnable)
        memory[address] = dataIn;
    dataOut = memory[address];
end
endmodule
