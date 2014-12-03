vlog -sv -reportprogress 300 -work work mp1.v
vsim -voptargs="+acc" test_ALU
run -all