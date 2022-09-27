transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/github_project/fpga_labs_21_2/lab1/src {H:/Meu Drive/estudos/2021.2/CD II/github_project/fpga_labs_21_2/lab1/src/fulladder.sv}

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/github_project/fpga_labs_21_2/lab1/fpga/../sim {H:/Meu Drive/estudos/2021.2/CD II/github_project/fpga_labs_21_2/lab1/fpga/../sim/fulladder_test.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  fulladder_test

add wave *
view structure
view signals
run -all
