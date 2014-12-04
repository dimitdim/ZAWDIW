vlog -reportprogress 300 -work work InstructionDecoder.v
vsim -voptargs="+acc" TestInstructionDecoder

add wave -position insertpoint \
sim:/TestInstructionDecoder/ALUOp \
sim:/TestInstructionDecoder/RegWr \
sim:/TestInstructionDecoder/PCWr \
sim:/TestInstructionDecoder/MemOut \
sim:/TestInstructionDecoder/ALUSrc \
sim:/TestInstructionDecoder/DmWr \
sim:/TestInstructionDecoder/RegDst \
sim:/TestInstructionDecoder/PCSrc \
sim:/TestInstructionDecoder/clk

run 1000