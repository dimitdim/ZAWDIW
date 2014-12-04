// register
// given; defines a 1-bit register
module register(q, d, wrenable, clk);
input	d;
input	wrenable;
input	clk;
output reg q;

always @(posedge clk) begin
    if(wrenable) begin
	q = d;
    end
end
endmodule

// register32
// defines a 32-bit register
module register32(q, d, wrenable, clk);
input[31:0] d;
input wrenable;
input clk;
output reg[31:0] q;

always @(posedge clk) begin
    if(wrenable) begin
        q = d;
    end
end
endmodule

// register32zero
// defines a 32-bit register that only outputs 0
module register32zero(q, d, wrenable, clk);
input[31:0] d;
input wrenable;
input clk;
output reg[31:0] q;

always @(posedge clk) begin
    if (wrenable) begin
        q = 0;
    end
end
endmodule

module testregisters;

reg[31:0] data;
reg wrenable;
reg clk;
wire[31:0] out;

register32zero dut(out, data, wrenable, clk);

initial begin
data=25;
wrenable=1;
#5; clk=0; #5; clk=1; #5 clk=0;
$display("data %b", data);
$display("out  %b", out);
end

endmodule

// None of the below works
//// 'harness'
//// all it does is start the test
//module testregistersharness;
//
//wire data;
//wire out;
//wire wrenable;
//wire clk;
//
//reg begintest;
//
//register DUT(out, data, wrenable, clk);
//testregisters tester(begintest, endtest, dutpassed, data, out, wrenable, clk);
//
//initial begin
//begintest=0;
//#10;
//begintest=1;
//#1000;
//end
//
//// when endtest becomes true, display result
//always @(posedge endtest) begin
//$display("data: %b", data);
//$display("out: %b", out);
//$display(dutpassed);
//end
//endmodule
//
//// actual test module
//module testregisters(begintest, endtest, dutpassed,
//                     data, out, wrenable, clk);
//output reg endtest;
//output reg dutpassed;
//input begintest;
//
//output reg data;
//output reg clk;
//output reg wrenable;
//output reg out;
//
//initial begin
//data=0;
//clk=0;
//wrenable=0;
//out=0;
//end
//
//always @(posedge begintest) begin
//endtest=0;
//dutpassed=1;
//#10
//
////test case 1: does the 1-bit register output d
//data=1;
//wrenable=1;
//#5 clk=1; #5 clk=0;
//if (out != data) begin
//    dutpassed=0;
//    $display("test failed");
//    end
//
//#5;
//endtest=1;
//end
//endmodule

