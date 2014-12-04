vlog -reportprogress 300 -work work ProgramCounter.v
vsim -voptargs="+acc" TestProgramCounter

add wave -position insertpoint \
sim:/TestProgramCounter/WrEn \
sim:/TestProgramCounter/Src \
sim:/TestProgramCounter/Out \
sim:/TestProgramCounter/clk

run 500
wave zoom full