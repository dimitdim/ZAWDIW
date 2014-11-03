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