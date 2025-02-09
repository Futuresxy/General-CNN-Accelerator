onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib CNN_Module_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {CNN_Module.udo}

run -all

quit -force
