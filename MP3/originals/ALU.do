vlog -sv -reportprogress 300 -work work ALU.v
vsim -voptargs="+acc" test_ALU
run -all