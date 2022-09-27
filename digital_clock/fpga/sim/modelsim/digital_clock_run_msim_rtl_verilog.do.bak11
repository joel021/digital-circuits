transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/updowncounter.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/stopwatch.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/hexto7seg.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/fsm.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/displayNdigit.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/CounterTime.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/src {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/src/BCDCounter.sv}

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/digital_clock/fpga/../sim {H:/Meu Drive/estudos/2021.2/CD II/digital_clock/fpga/../sim/stopwatch_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  stopwatch_tb

add wave *
view structure
view signals
run -all
