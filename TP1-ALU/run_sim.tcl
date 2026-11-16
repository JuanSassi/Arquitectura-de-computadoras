# Corre la simulacion del testbench en modo batch, para validar rapido
# que el diseno pasa antes de abrir la GUI de Vivado.
# Uso: vivado -mode batch -source run_sim.tcl

set origin_dir [file dirname [info script]]
open_project [file join $origin_dir "vivado_proj" "alu_tp1.xpr"]

launch_simulation
run all
