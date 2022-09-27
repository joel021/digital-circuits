transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/src/xycounter.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/src/Mem.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/src/VGATimer.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/src/VGADisplayDriver.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/src/top.sv}

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab7/fpga/../src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab7/fpga/../src/top_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
