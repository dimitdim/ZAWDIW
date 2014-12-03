vlog -reportprogress 300 -work work shiftregister.v
vsim -voptargs="+acc" testshiftregister

add wave -position insertpoint \
sim:/testshiftregister/clk \
sim:/testshiftregister/peripheralClkEdge \
sim:/testshiftregister/parallelLoad \
sim:/testshiftregister/parallelDataIn \
sim:/testshiftregister/serialDataIn \
sim:/testshiftregister/parallelDataOut \
sim:/testshiftregister/serialDataOut

run 2000
wave zoom full