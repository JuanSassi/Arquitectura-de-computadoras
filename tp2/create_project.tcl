# Crea el proyecto de Vivado (Basys3) con fuentes, constraints y testbenches.
# Uso:  vivado -mode batch -source create_project.tcl
#  o en el Tcl Console de Vivado:  source {<ruta>/create_project.tcl}

set origin_dir [file dirname [file normalize [info script]]]
set proj_name  "uart_alu"
set proj_dir   [file join $origin_dir "vivado_proj"]

create_project $proj_name $proj_dir -part xc7a35tcpg236-1 -force
catch { set_property board_part digilentinc.com:basys3:part0:1.2 [current_project] }

add_files -norecurse [glob [file join $origin_dir "src" "*.v"]]
add_files -fileset constrs_1 -norecurse [file join $origin_dir "constraints" "basys3.xdc"]
add_files -fileset sim_1 -norecurse [glob [file join $origin_dir "sim" "*.v"]]

set_property top uart_alu_top [current_fileset]
# testbench por defecto en simulacion: el de integracion final
# (se puede cambiar: Simulation Settings > Simulation top module name)
set_property top tb_uart_alu_top [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Proyecto '$proj_name' creado en: $proj_dir"
