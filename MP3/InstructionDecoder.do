vlog -reportprogress 300 -work work InstructionDecoder.v
vsim -voptargs="+acc" TestInstructionDecoder
run -all