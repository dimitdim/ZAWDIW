vlog -reportprogress 300 -work work fulladder4bit.v
vsim -voptargs="+acc" testFullAdder4bit

add wave -position insertpoint \
sim:/testFullAdder4bit/a \
sim:/testFullAdder4bit/b \
sim:/testFullAdder4bit/sum \
sim:/testFullAdder4bit/carryout

run -all
wave zoom full