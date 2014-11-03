`include "DataMemory.v"
`include "ShiftRegister.v"
`include "inputconditioner.v"
`include "FSM.v"

module spiMemory(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, faultinjector_pin, leds, state);
input		clk;
input		sclk_pin;
input		cs_pin;
output reg	miso_pin;
input		mosi_pin;
input		faultinjector_pin;
output[7:0]     leds;
output[3:0]	state;

// wires for all the input conditioners
wire cs_con, cs_pos, cs_neg;
wire mosi_con, mosi_pos, mosi_neg;
wire sclk_con, sclk_pos, sclk_neg;

wire[7:0] dm_out;
reg[6:0] dm_addr;
wire dm_we;
wire[7:0] dm_in;

wire[7:0] parallel_out;
wire serial_out;
wire parallel_load;
wire serial_in;
wire[7:0] parallel_in;

wire sr_we, addrlatch_en, miso_en;
wire[3:0] currentstate;

assign dm_in=parallel_out;
assign parallel_load=sr_we;
assign parallel_in=dm_out;
assign serial_in=mosi_con;
assign leds[3]=miso_en;
assign leds[2]=addrlatch_en;
assign leds[1]=dm_we;
assign leds[0]=sr_we;
assign state=currentstate;

initial dm_addr=0;
//initial parallel_out=0;

// input conditioners
inputconditioner cs_conditioner(clk, cs_pin, cs_con, cs_pos, cs_neg);
inputconditioner mosi_conditioner(clk, mosi_pin, mosi_con, mosi_pos, mosi_neg);
inputconditioner sclk_conditioner(clk, sclk_pin, sclk_con, sclk_pos, sclk_neg);

// data memory
DataMemory dm(clk, dm_out, dm_addr, dm_we, dm_in);

// shift register
shiftregister sr(clk, sclk_pos, parallel_load, parallel_in, serial_in, parallel_out, serial_out);

// fsm
finiteStateMachine fsm(clk, cs_con, sclk_pos, parallel_out[7], sr_we, dm_we, addrlatch_en, miso_en, currentstate);

// flipflop and miso buffer
always @(posedge clk) begin
	if (addrlatch_en==1) dm_addr=parallel_out[6:0];
	if (sclk_neg == 1 && miso_en==1) begin
		miso_pin = serial_out;
	end
        if (dm_we==1) begin
	$display("dm_we: %b | dm_addr: %b | dm_in: %b", addrlatch_en, dm_addr, parallel_out);
	end
        if (addrlatch_en==1) begin
	$display("addrlatch_en: %b | dm_addr: %b | parallel_out: %b", addrlatch_en, dm_addr, parallel_out);
	end
        if (sr_we==1) begin
	$display("sr_we: %b | dm_out: %b | dm_addr: %b| parallel_out: %b", sr_we, dm_out, dm_addr, parallel_out);
	end
//	if (dm_we==1) begin
//		$display("miso_pin: %b | serial_out: %b", miso_pin, serial_out);
//		$display("sr_we: %b | dm_out: %b | parallel_out: %b", sr_we, dm_out, mosi_con, parallel_out);
//		$display("sr_we: %b | dm_out: %b | mosi_con: %b | dm_addr: %b", sr_we, dm_out, mosi_con, dm_addr);
//		$display("sr_we: %b | dm_out: %b | mosi_con: %b | dm_out: %b", sr_we, dm_out, mosi_con, dm_out);
//		$display("dm_we: %b", dm_we);
//	end
end

endmodule

module testspimemory;
reg clk;
reg sclk_pin;
reg cs_pin;
wire miso_pin;
reg mosi_pin;
reg faultinjector_pin;
wire[7:0] leds;
wire[3:0] state;

// for testing fsm
//reg cs, sclk_edge, read_write;
//wire sr_we, dm_we, addrlatch_en, miso_en;
//wire [3:0] current;
//reg[4:0] sclk_temp;
//
//finiteStateMachine dut(clk, cs, sclk_edge, read_write, sr_we, dm_we, addrlatch_en, miso_en, current);
//

spiMemory dut(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, faultinjector_pin, leds, state);

initial begin clk=0; sclk_pin=0; cs_pin=1; mosi_pin=0; faultinjector_pin=0; end
// normal clock
always #10 clk=!clk;
always #300 sclk_pin=!sclk_pin;
// serial clock
//always #10 begin
//	sclk_temp=sclk_temp+1;
//	sclk_temp=sclk_temp % 10;
//	if (sclk_temp==1) sclk_edge=1;
//	else sclk_edge=0;
//end

//initial begin
//cs=1;
//read_write=1;
//#100
//cs=0; #2000
//cs=1;
//end

initial begin
#200
cs_pin=0;
#100

mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=0; #600

mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=0; #600

cs_pin=1;
#900
cs_pin=0;

mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=1; #600
mosi_pin=0; #600
mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=1; #600
mosi_pin=1; #600

mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600
mosi_pin=0; #600

cs_pin=1;
end

endmodule
