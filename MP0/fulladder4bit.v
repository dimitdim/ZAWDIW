`define XOR xor #50
`define AND and #50
`define OR or #50
`define NOT not #50

module FullAdder1bit(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;

wire AxorB;
wire AandB;
wire AxorBandC;

`XOR xor0(AxorB, a, b);
`AND and0(AandB, a, b);
`AND and1(AxorBandC, AxorB, carryin);

`XOR xor1(out, AxorB, carryin);
`OR or0(carryout, AxorBandC, AandB);

endmodule

module FullAdder4bit(sum,carryout,overflow,a,b);
output[3:0] sum; // 2?s complement sum of a and b
output carryout; // Carry out of the summation of a and b
output overflow; // True if the calculation resulted in an overflow
input[3:0] a; // First operand in 2?s complement format
input[3:0] b; // Second operand in 2?s complement format

wire carry0, carry1, carry2;

FullAdder1bit adder0 (sum[0], carry0, a[0], b[0], 0);
FullAdder1bit adder1 (sum[1], carry1, a[1], b[1], carry0);
FullAdder1bit adder2 (sum[2], carry2, a[2], b[2], carry1);
FullAdder1bit adder3 (sum[3], carryout, a[3], b[3], carry2);

wire notA, notB, notSUM;
`NOT not0 (notA, a[3]);
`NOT not1 (notB, b[3]);
`NOT not2 (notSUM, sum[3]);

wire orInput1, orInput2;
`AND and0 (orInput1, a[3], b[3], notSUM);
`AND and1 (orInput2, notA, notB, sum[3]);

`OR or0 (overflow, orInput1, orInput2);

endmodule

module testFullAdder4bit;
reg [3:0] a;
reg [3:0] b;
wire [3:0] sum;
wire carryout;
parameter del = 1000;
FullAdder4bit adder (sum, carryout, overflow, a, b);
initial begin
$display("<---------------- 4 Bit Full Adder ---------------->");
a=4; b=0; #del 
$display(" testing ... %b %b | %d %d | %b %b %b %b", a, b, a, b, a[0], a[1], a[2], a[3]);
$display("<---------------Testing overflow and sum MSB for (a MSB = b MSB) with different overflows---------------->");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=2; b=3; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   0   |    0     |    0     |    0", a, a, b, b, sum, sum, carryout, overflow);
a=7; b=7; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   0   |    0     |    1     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=-4; b=-4; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   1   |    1     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=-6; b=-7; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   1   |    1     |    1     |    0", a, a, b, b, sum, sum, carryout, overflow);

$display("<------------Testing for carryout=1 when the absolute value of the negative number is larger------------->");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=1; b=-3; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   1   |    0     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=5; b=-3; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   1   |    1     |    0     |    0", a, a, b, b, sum, sum, carryout, overflow);
a=-3; b=7; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   0   |    1     |    0     |    0", a, a, b, b, sum, sum, carryout, overflow);
a=-7; b=6; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   0   |    0     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
$display("<-------------------------------------Testing that inverses sum to 0------------------------------------->");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=4; b=-4; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   1   |    1     |    0     |    0", a, a, b, b, sum, sum, carryout, overflow);
$display("<------------------------------Sum to -8 and sum to +8; one should overflow------------------------------>");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=4; b=4; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   0   |    0     |    1     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=-2; b=-6; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   1   |    1     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
$display("<-------------------------------------------------Sum to -9---------------------------------------------->");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=-5; b=-4; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   1   |    1     |    1     |    0", a, a, b, b, sum, sum, carryout, overflow);
$display("<--------------------------------------Adding x to 0 should equal x-------------------------------------->");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=-8; b=0; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   0   |    0     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=0; b=-8; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   0   |   1   |    0     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
$display("<-----------------------------Testing some numbers that haven't been tested------------------------------>");
$display("                     ACTUAL                               ||                    EXPECTED                  ");
$display("  a       |    b      |    sum      | carryout | overflow || a MSB | b MSB | carryout | overflow | sum MSB");
a=-7; b=1; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   0   |    0     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);
a=-3; b=-2; #del
$display("%b (%d) | %b (%d) | %b  (%d)  |    %b     |     %b    ||   1   |   1   |    1     |    0     |    1", a, a, b, b, sum, sum, carryout, overflow);

end
endmodule
