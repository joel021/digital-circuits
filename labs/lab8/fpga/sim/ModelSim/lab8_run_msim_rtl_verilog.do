transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/mux4.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/mux2.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/comparator.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/fulladder.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/datapath.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/synchronous_R.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/top.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/shifter.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/rom_module.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/risc231_m1.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/register_file.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/ram_module.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/logical.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/alu.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/addsub.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/controller.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/aludec.sv}
vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/src {G:/My Drive/estudos/2021.2/CD II/labs/lab8/src/adder.sv}

vlog -sv -work work +incdir+G:/My\ Drive/estudos/2021.2/CD\ II/labs/lab8/fpga/../sim/tb {G:/My Drive/estudos/2021.2/CD II/labs/lab8/fpga/../sim/tb/risc231_m1_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  risc231_m1_tb

add wave *
view structure
view signals
run -all
