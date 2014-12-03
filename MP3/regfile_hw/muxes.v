// Deliverable 4
module mux32to1by1(out, address, muxInputs);
	input[31:0] muxInputs;
	input[4:0] address;
	output out;
	
	assign out = muxInputs[address];
endmodule


// Deliverable 5 (SUCKS)
module mux32to1by32(out, address, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9,
                    in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20,
                    in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31);

	input[31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9,
          	  in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20,
          	  in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;

	input[4:0] address;
	output[31:0] out;
	
	wire[31:0] mux[31:0]; // creates 2D array of wires
	
	// oh god why
	// the sheer copy pasta of it
	assign mux[0]=in0;
	assign mux[1]=in1;
	assign mux[2]=in2;
	assign mux[3]=in3;
	assign mux[4]=in4;
	assign mux[5]=in5;
	assign mux[6]=in6;
	assign mux[7]=in7;
	assign mux[8]=in8;
	assign mux[9]=in9;
	assign mux[10]=in10;
	assign mux[11]=in11;
	assign mux[12]=in12;
	assign mux[13]=in13;
	assign mux[14]=in14;
	assign mux[15]=in15;
	assign mux[16]=in16;
	assign mux[17]=in17;
	assign mux[18]=in18;
	assign mux[19]=in19;
	assign mux[20]=in20;
	assign mux[21]=in21;
	assign mux[22]=in22;
	assign mux[23]=in23;
	assign mux[24]=in24;
	assign mux[25]=in25;
	assign mux[26]=in26;
	assign mux[27]=in27;
	assign mux[28]=in28;
	assign mux[29]=in29;
	assign mux[30]=in30;
	assign mux[31]=in31;

	assign out =  mux[address];
endmodule

module mux32to1by32_better(out, address, in);
	
	// Made with sublime text 2's awesome regex find and replace
	input[31:0] in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7], in[8], in[9],
        in[10], in[11], in[12], in[13], in[14], in[15], in[16], in[17], in[18], in[19], in[20],
        in[21], in[22], in[23], in[24], in[25], in[26], in[27], in[28], in[29], in[30], in[31];

	input[4:0] address;
	output[31:0] out;

	wire[31:0] mux[31:0];

        assign mux[0]=in[0];
	assign mux[1]=in[1];
	assign mux[2]=in[2];
	assign mux[3]=in[3];
	assign mux[4]=in[4];
	assign mux[5]=in[5];
	assign mux[6]=in[6];
	assign mux[7]=in[7];
	assign mux[8]=in[8];
	assign mux[9]=in[9];
	assign mux[10]=in[10];
	assign mux[11]=in[11];
	assign mux[12]=in[12];
	assign mux[13]=in[13];
	assign mux[14]=in[14];
	assign mux[15]=in[15];
	assign mux[16]=in[16];
	assign mux[17]=in[17];
	assign mux[18]=in[18];
	assign mux[19]=in[19];
	assign mux[20]=in[20];
	assign mux[21]=in[21];
	assign mux[22]=in[22];
	assign mux[23]=in[23];
	assign mux[24]=in[24];
	assign mux[25]=in[25];
	assign mux[26]=in[26];
	assign mux[27]=in[27];
	assign mux[28]=in[28];
	assign mux[29]=in[29];
	assign mux[30]=in[30];
	assign mux[31]=in[31];

	assign out =  mux[address];
endmodule
