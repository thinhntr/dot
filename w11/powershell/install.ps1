if (-not (Get-Command link -ErrorAction Ignore)) {
    Write-Host "Failed!!! Run $(git rev-parse --show-toplevel)/w11/bootstrap.ps1 first" -ForegroundColor Red
    pause
    exit 1
}

Set-Location $PSScriptRoot

$targets = @("Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")

foreach ($item in $targets) {
  link $item
}

pause
