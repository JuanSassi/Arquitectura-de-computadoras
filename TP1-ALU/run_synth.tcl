# Corre sintesis del top de la placa para validar que no hay
# conflictos de pines ni errores de RTL antes de abrir la GUI.
# Uso: vivado -mode batch -source run_synth.tcl

set origin_dir [file dirname [info script]]
open_project [file join $origin_dir "vivado_proj" "alu_tp1.xpr"]

reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    puts "SINTESIS FALLO"
    exit 1
} else {
    puts "SINTESIS OK"
}
