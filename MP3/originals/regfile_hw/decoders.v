module decoder1to32(out, enable, address);
output[31:0]	out;
input		enable;
input[4:0]	address;

wire[31:0] out;

assign out = enable<<address; 
//assign out = (enable) ? (1 << address) : 32'b0;
endmodule

// Deliverable 6
// uhhh
// ohhhh the assign statement works because for a decoder only one of the outputs is 1,
// all the others are 0, so it makes sense to shift 1 to get the bus output. ha

module testdecoder;
wire[31:0] out;
reg enable;
reg[4:0] address;

decoder1to32 decoder(out, enable, address);

initial begin
enable=1;
address=15;
$display("enable: %b || address: %b (%d)", enable, address, address);
$display("output: %b (%d)", out, out);
end

endmodule
