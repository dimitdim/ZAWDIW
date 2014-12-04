vlog -sv -reportprogress 300 -work work CPU.v
vsim -voptargs="+acc" TestCPU

run -all