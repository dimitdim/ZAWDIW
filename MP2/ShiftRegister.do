vlog -reportprogress 300 -work work shiftregister.v
vsim -voptargs="+acc" testshiftregister

add wave -position insertpoint \
sim:/testshiftregister/clk \
sim:/testshiftregister/peripheralClkEdge \
sim:/testshiftregister/serialDataIn \
sim:/testshiftregister/parallelDataOut

run 1000
wave zoom full