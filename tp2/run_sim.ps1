<#
  Corre los testbenches con xsim (Vivado) desde la linea de comandos.

  Uso (desde la carpeta uart_alu):
      .\run_sim.ps1                      # todos los testbenches, en orden
      .\run_sim.ps1 -Tb tb_uart_rx       # solo uno
      .\run_sim.ps1 -Tb tb_uart_rx -Wave # y deja build\tb_uart_rx.wdb para abrir en Vivado
      .\run_sim.ps1 -Real                # ademas corre baud/top con 100 MHz reales (mas lento)

  Los resultados quedan en build\<tb>.log. Cada tb imprime una linea final
  "TB_xxx: PASO ..." o "TB_xxx: FALLO ...".
#>
param(
    [string]$Tb = "",
    [switch]$Wave,
    [switch]$Real,
    [string]$VivadoBin = "D:\Facultad\Arquitectura\Vivado\2025.2\Vivado\bin"
)

$ErrorActionPreference = "Stop"
$root  = Split-Path -Parent $MyInvocation.MyCommand.Path
$build = Join-Path $root "build"
New-Item -ItemType Directory -Force $build | Out-Null

# Orden de integracion: modulo por modulo y despues juntos.
$all = @("tb_baud_rate_gen", "tb_uart_rx", "tb_uart_tx", "tb_uart_loopback",
         "tb_sync_fifo", "tb_uart_interface", "tb_alu_uart_ctrl", "tb_uart_alu_top")
$list = if ($Tb) { @($Tb) } else { $all }

# Si $Real: (tb, generics) extra con el reloj real de la Basys3 (100 MHz).
$extra = @()
if ($Real) {
    $extra += ,@("tb_baud_rate_gen", "CLK_FREQ=100000000")
    $extra += ,@("tb_uart_rx",       "CLK_FREQ=100000000")
    $extra += ,@("tb_uart_tx",       "CLK_FREQ=100000000")
    $extra += ,@("tb_uart_alu_top",  "CLK_FREQ=100000000 NUM_RANDOM=3")
}

function Invoke-Tb([string]$name, [string]$generics, [string]$tag) {
    $log = Join-Path $build "$tag.log"
    $src = Get-ChildItem (Join-Path $root "src") -Filter *.v | ForEach-Object { $_.FullName }
    $tbf = Join-Path $root "sim\$name.v"
    Push-Location $build
    try {
        & "$VivadoBin\xvlog.bat" $src $tbf | Out-File "$tag.xvlog.log" -Encoding utf8
        if ($LASTEXITCODE -ne 0) { Get-Content "$tag.xvlog.log" | Select-Object -Last 20 | Write-Host; throw "xvlog fallo en $name" }
        $gen = @()
        foreach ($g in ($generics -split ' ' | Where-Object { $_ })) { $gen += @("-generic_top", "`"$g`"") }
        & "$VivadoBin\xelab.bat" $name -s $tag -debug typical @gen | Out-File "$tag.xelab.log" -Encoding utf8
        if ($LASTEXITCODE -ne 0) { Get-Content "$tag.xelab.log" | Select-Object -Last 20 | Write-Host; throw "xelab fallo en $name" }
        if ($Wave) {
            Set-Content "$tag.tcl" "log_wave -recursive *`nrun all`nexit"
            & "$VivadoBin\xsim.bat" $tag -wdb "$tag.wdb" -tclbatch "$tag.tcl" | Out-File $log -Encoding utf8
        } else {
            & "$VivadoBin\xsim.bat" $tag -runall | Out-File $log -Encoding utf8
        }
    } finally { Pop-Location }
    $res = Select-String -Path $log -Pattern "^(TB_\w+: .*)$" | ForEach-Object { $_.Matches[0].Groups[1].Value }
    $bad = Select-String -Path $log -Pattern "FALLO" | Select-Object -First 5
    if ($res) { Write-Host $res } else { Write-Host "$name : sin linea de resultado (ver $log)" }
    if ($bad) { $bad | ForEach-Object { Write-Host ("    " + $_.Line) } }
    return [bool]($res -match "PASO")
}

$ok = $true
foreach ($t in $list) {
    if (-not (Invoke-Tb $t "" $t)) { $ok = $false }
}
foreach ($e in $extra) {
    if (-not (Invoke-Tb $e[0] $e[1] ($e[0] + "_real"))) { $ok = $false }
}
if ($ok) { Write-Host "`n== TODOS LOS TESTBENCHES PASARON ==" } else { Write-Host "`n== HAY TESTBENCHES CON FALLOS =="; exit 1 }
