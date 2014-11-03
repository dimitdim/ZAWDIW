vlog -reportprogress 300 -work work spimemory.v
vsim -voptargs="+acc" testspimemory

add wave -position insertpoint \
sim:/testspimemory/miso_pin \
sim:/testspimemory/cs_pin \
sim:/testspimemory/mosi_pin \
sim:/testspimemory/sclk_pin \
sim:/testspimemory/clk

run 10000
wave zoom full