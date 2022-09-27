transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/shifter.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/logical.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/fulladder.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/alu.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/addsub.sv}
vlog -sv -work work +incdir+H:/Meu\ Drive/estudos/2021.2/CD\ II/labs/lab2b/src {H:/Meu Drive/estudos/2021.2/CD II/labs/lab2b/src/adder.sv}

