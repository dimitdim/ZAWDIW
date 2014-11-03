`include "DataMemory.v"
`include "ShiftRegister.v"
`include "inputconditioner.v"

module finiteStateMachine(clk, cs, sclk_edge, read_write, sr_we, dm_we, addrlatch_en, miso_en, currentstate);
input clk, cs, sclk_edge, read_write;
output reg sr_we, dm_we, addrlatch_en, miso_en;
//reg sr_we;
//assign sr_we=sr_wee;

parameter counttime = 8;
reg [3:0] count = 0;
output reg [3:0] currentstate = 0;

initial count=0;

always @(posedge clk) begin
	if (sclk_edge==1) begin
		count=count+1;
	end
	if (cs == 1) begin
		count=0;
		currentstate=0;
	end
	else case(currentstate)
		0 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=0;
			if (count == counttime) begin
				currentstate = 1;
                                count=0;
			end
		end
		1 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=1;	
			miso_en=0;
			if (read_write == 1) begin
				currentstate = 2;
			end else begin
				currentstate = 5;
			end
		end
		2 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=0;
			currentstate = 3;
		end
		3 : begin
			sr_we=1; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=0;
			currentstate = 4;
		end
		4 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=1;
			if (count == counttime)  begin
				currentstate = 7;
				count=0;
			end
		end
		5 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=0;
			if (count == counttime) begin
				currentstate = 6;
				count=0;
			end
		end
		6 : begin
			sr_we=0; 
			dm_we=1; 
			addrlatch_en=0;	
			miso_en=0;
			currentstate = 7;
		end
		7 : begin
			sr_we=0; 
			dm_we=0; 
			addrlatch_en=0;	
			miso_en=0;		
			count=0;
		end
	endcase
end

endmodule

module spiMemory(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, faultinjector_pin, leds);
input		clk;
input		sclk_pin;
input		cs_pin;
output		miso_pin;
input		mosi_pin;
input		faultinjector_pin;
output[7:0]     leds;

// wires for all the input conditioners
wire cs_con, cs_pos, cs_neg;
wire mosi_con, mosi_pos, mosi_neg;
wire sclk_con, sclk_pos, sclk_neg;

wire[7:0] dm_out;
wire[6:0] dm_addr;
wire[7:0] sr_out;

wire [7:0] parallel_out;
wire serial_out;

wire sr_we, dm_we, addrlatch_en, miso_en;
wire [3:0] currentstate;

//initial parallel_out=0;

// input conditioners
inputconditioner cs_conditioner(clk, cs_pin, cs_con, cs_pos, cs_neg);
inputconditioner mosi_conditioner(clk, mosi_pin, mosi_con, mosi_pos, mosi_neg);
inputconditioner sclk_conditioner(clk, sclk_pin, sclk_con, sclk_pos, sclk_neg);

// data memory
DataMemory dm(clk, dm_out, dm_addr, dm_we, sr_out);

// shift register
shiftregister sr(clk, sclk_pos, sr_we, dm_out, mosi_con, parallel_out, serial_out);

// fsm
finiteStateMachine fsm(clk, cs_con, sclk_pos, parallel_out[0], sr_we, dm_we, addrlatch_en, miso_en, currentstate);

// flipflop and miso buffer
always @(posedge clk) begin
	if (sclk_neg==1) begin
		if (miso_en==1) begin
			miso_pin = serial_out;
		end		
	end
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

// for testing fsm
//reg cs, sclk_edge, read_write;
//wire sr_we, dm_we, addrlatch_en, miso_en;
//wire [3:0] current;
//reg[4:0] sclk_temp;
//
//finiteStateMachine dut(clk, cs, sclk_edge, read_write, sr_we, dm_we, addrlatch_en, miso_en, current);
//

spiMemory dut(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, faultinjector_pin, leds);

initial begin clk=0; sclk_pin=0; cs_pin=1; mosi_pin=0; faultinjector_pin=0; end
// normal clock
always #10 clk=!clk;
always #100 sclk_pin=!sclk_pin;
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
#500
cs_pin=0;

mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=0; #200

mosi_pin=1; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=0; #200

cs_pin=1;
#500
cs_pin=0;

mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=0; #200
mosi_pin=1; #200
mosi_pin=1; #200

mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200
mosi_pin=0; #200

cs_pin=1;
end

endmodule
