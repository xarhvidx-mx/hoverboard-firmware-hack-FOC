# Build script for VARIANT_IBUS_TANK
# Run from repository root in PowerShell.
# Requires Windows Python launcher (py) and PlatformIO installed for Python 3.x.

$env:PWD = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-Host "Building VARIANT_IBUS_TANK..."
$build = py -3 -m platformio run -e VARIANT_IBUS_TANK -v
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed. See output above."
    exit $LASTEXITCODE
}

$src = ".\.pio\build\VARIANT_IBUS_TANK\firmware.bin"
$dst = ".\artifacts\firmware-IBUS_TANK.bin"
$dst2 = ".\artifacts\firmware-IBUS_TANK-lowspd.bin"   # distinct, tuned build name
if (Test-Path $src) {
    Copy-Item -Path $src -Destination $dst -Force
    Write-Host "Copied firmware to $dst"
    # Also copy with a distinctive filename so you can spot the tuned build easily
    Copy-Item -Path $src -Destination $dst2 -Force
    Write-Host "Copied firmware to $dst2"
} else {
    Write-Warning "Build succeeded but firmware.bin not found at $src"
}

Write-Host "Done."