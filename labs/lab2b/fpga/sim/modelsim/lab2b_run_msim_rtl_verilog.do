transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/shifter.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/logical.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/fulladder.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/alu.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/addsub.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/comparator.sv}
vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/adder.sv}

vlog -sv -work work +incdir+G:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/fpga/../sim {G:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/fpga/../sim/alu_32bit_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_32bit_tb

add wave *
view structure
view signals
run -all
