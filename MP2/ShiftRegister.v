module shiftregister(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
parameter width = 8;
input               clk;
input               peripheralClkEdge;
input               parallelLoad;
output[width-1:0]   parallelDataOut;
output              serialDataOut;
input[width-1:0]    parallelDataIn;
input               serialDataIn;
reg[width-1:0]      shiftregistermem;
assign serialDataOut=shiftregistermem[0];
assign parallelDataOut=shiftregistermem;
always @(posedge clk) begin
    if(parallelLoad==1) assign shiftregistermem = parallelDataIn;
    else if(peripheralClkEdge==1) begin
	shiftregistermem = {serialDataIn,shiftregistermem[width-1:1]};
	$display("balls");
	end
end
endmodule

module testshiftregister;
reg             clk;
reg             peripheralClkEdge;
reg             parallelLoad;
wire[7:0]       parallelDataOut;
wire            serialDataOut;
reg[7:0]        parallelDataIn;
reg             serialDataIn; 
shiftregister #(8) sr(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
initial clk=0;
always #10 clk=!clk;
initial parallelDataIn=16'hA5;
initial parallelLoad=0;
initial begin
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=1; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=1; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=0; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=1; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=1; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0; #45
serialDataIn=0; #45
peripheralClkEdge=1; #10
$display("%b", parallelDataOut);
peripheralClkEdge=0;
end

endmodule

