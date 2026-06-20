Set-Location $PSScriptRoot

$targets = @("Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")

function link($item) {
  $original = (Resolve-Path ".\${item}")
  $target =  "$HOME\${item}"
  echo "linking $original to $target"
  New-Item -ItemType HardLink -Path $target -Target $original -ErrorAction SilentlyContinue
}

foreach ($item in $targets) {
  link $item
}

pause
