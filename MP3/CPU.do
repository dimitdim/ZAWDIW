vlog -sv -reportprogress 300 -work work CPU.v
vsim -voptargs="+acc" CPUtest

add wave -position insertpoint \
sim:/CPUtest/res \
sim:/CPUtest/s0 \
sim:/CPUtest/clk

run 500
wave zoom full