# Programa la Basys3 con build/uart_alu_top.bit.  Uso: vivado -mode batch -source program_board.tcl
set origin_dir [file dirname [file normalize [info script]]]
open_hw_manager
connect_hw_server
open_hw_target
set dev [lindex [get_hw_devices xc7a35t_0] 0]
current_hw_device $dev
set_property PROGRAM.FILE [file join $origin_dir "build" "uart_alu_top.bit"] $dev
program_hw_devices $dev
puts "PROGRAMACION_OK"
close_hw_target
disconnect_hw_server
close_hw_manager
