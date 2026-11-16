# Script para crear el proyecto de Vivado desde cero (reproducible).
# Uso:
#   vivado -mode batch -source create_project.tcl
# o desde el Tcl Console de Vivado:
#   source {D:/Facultad/Arquitectura/Tp1/alu_basys3/create_project.tcl}

set origin_dir [file dirname [info script]]
set proj_name  "alu_tp1"
set proj_dir   [file join $origin_dir "vivado_proj"]

create_project $proj_name $proj_dir -part xc7a35tcpg236-1 -force

# Board part de la Basys3 (si esta instalado el board file de Digilent).
# Si no esta disponible, no falla el resto del script.
catch { set_property board_part digilentinc.com:basys3:part0:1.2 [current_project] }

add_files -norecurse [glob [file join $origin_dir "src" "*.v"]]
add_files -fileset constrs_1 -norecurse [file join $origin_dir "constraints" "basys3.xdc"]
add_files -fileset sim_1 -norecurse [glob [file join $origin_dir "sim" "*.v"]]

set_property top alu_basys3_top [current_fileset]
set_property top alu_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Proyecto '$proj_name' creado en: $proj_dir"
