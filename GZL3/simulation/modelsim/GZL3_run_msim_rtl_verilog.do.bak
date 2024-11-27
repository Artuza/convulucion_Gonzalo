transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Q/GZL3 {D:/Q/GZL3/convolution.v}

vlog -vlog01compat -work work +incdir+D:/Q/GZL3 {D:/Q/GZL3/convolution_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  convolution_tb

add wave *
view structure
view signals
run -all
