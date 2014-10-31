
module inputconditioner(clk, noisysignal, conditioned, positiveedge, negativeedge);
output reg conditioned = 0;
output reg positiveedge = 0;
output reg negativeedge = 0;
input clk, noisysignal;

parameter counterwidth = 3;
parameter waittime = 3;
reg[counterwidth-1:0] counter =0;
// not sure if the waittime-2 thing is strictly necessary
// also because buffer[1] and buffer[0] are explicitly referenced changing waittime would break everything
reg[waittime-2:0] buffer = 0;

always @(posedge clk) begin
	// if buffer 1 is the same as conditioned, no need to wait to see if change is consistent
	if (conditioned == buffer[1]) begin
		counter <= 0;
		positiveedge = 0;
		negativeedge = 0;
	//otherwise we check the counter
	end else begin 
		// if the counter is at the end point, we approve this input
		if (counter == waittime) begin
			counter <= 0;
			conditioned <= buffer[1];
			// 
			if (buffer[1] == 1) begin
					positiveedge <= 1;
			end else begin
					negativeedge <= 1;
			end
		// otherwise we increment
		end else begin
			counter <= counter + 1;
			// and if the input is changing we discard it
			if (buffer[1] != buffer[0]) begin
				counter <= 0;
			end
		end
	end
	// move things along in the buffer chain
	buffer[1] = buffer[0];
	buffer[0] = noisysignal;
end

//reg synchronizer0 = 0;
//reg synchronizer1 = 0;
//always @(posedge clk ) begin
//    if(conditioned == synchronizer1)
//        counter <= 0;
//    else begin
//        if( counter == waittime) begin
//            counter <= 0;
//            conditioned <= synchronizer1;
//        end
//        else 
//            counter <= counter+1;
//    end
//    synchronizer1 = synchronizer0;
//    synchronizer0 = noisysignal;
//end
endmodule


module testConditioner;
wire conditioned;
wire rising;
wire falling;
reg pin, clk;
reg ri;
always @(posedge clk) ri=rising;
inputconditioner dut(clk, pin, conditioned, rising, falling);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock

initial begin
// Your Test Code
// Be sure to test each of the three things the conditioner does:
// Synchronize, Clean, Preprocess (edge finding)

pin=0; #100
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=1; #1000
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=0; #800
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=1; #20
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=0; #100
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=1; #1000
$display("pin | conditioned | rising | falling");
$display("%b | %b | %b | %b", pin, conditioned, rising, falling);
pin=0;
end

endmodule
