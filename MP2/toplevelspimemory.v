// This is the top-level module for the project!
// Set this as the top module in Xilinx, and place all your modules within this one.
`include "spimemory.v"

module mp2(led, gpioBank1, gpioBank2, clk, sw, btn);
output reg [7:0] led;
output reg [3:0] gpioBank1;
input[3:0] gpioBank2;
input clk;
input[7:0] sw;
input[3:0] btn;

wire[3:0] state; // we can take it out if we end up needing to

// Your MP2 code goes here!

spiMemory spi(clk, gpioBank2[0], gpioBank2[1], gpioBank1[0], gpioBank2[2], sw[0], led, state);

endmodule
