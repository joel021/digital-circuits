transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab6/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab6/src/displayNdigit.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab6/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab6/src/seebounce.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab6/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab6/src/debouncer.sv}

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab6/fpga/../sim {H:/Meu Drive/estudos/2021.2/CD II/labs/lab6/fpga/../sim/debounce_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  debounce_tb

add wave *
view structure
view signals
run -all
