# Sintesis + implementacion + reportes de timing/utilizacion (sin generar bitstream).
# Uso:  vivado -mode batch -source run_synth.tcl
set origin_dir [file dirname [file normalize [info script]]]
source [file join $origin_dir "create_project.tcl"]
file mkdir [file join $origin_dir "build"]
# jerarquia sin aplanar: permite ver recursos por modulo
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
report_utilization              -file [file join $origin_dir "build" "utilization.rpt"]
report_utilization -hierarchical -file [file join $origin_dir "build" "utilization_hier.rpt"]
report_timing_summary           -file [file join $origin_dir "build" "timing.rpt"]
report_timing -max_paths 1 -sort_by slack -file [file join $origin_dir "build" "critical_path.rpt"]
puts "Reportes en build/: utilization.rpt, utilization_hier.rpt, timing.rpt, critical_path.rpt"
