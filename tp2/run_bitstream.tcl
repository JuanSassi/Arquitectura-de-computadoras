# Sintesis + implementacion + bitstream.  Uso: vivado -mode batch -source run_bitstream.tcl
set origin_dir [file dirname [file normalize [info script]]]
source [file join $origin_dir "create_project.tcl"]
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
set bit [glob [file join $proj_dir "uart_alu.runs" "impl_1" "*.bit"]]
file mkdir [file join $origin_dir "build"]
file copy -force $bit [file join $origin_dir "build" "uart_alu_top.bit"]
puts "Bitstream: build/uart_alu_top.bit"
