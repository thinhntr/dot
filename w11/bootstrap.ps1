Set-Location $PSScriptRoot

$newPath = Resolve-Path ".\utils"
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")

if ($currentPath -notlike "*$newPath*") {
    [Environment]::SetEnvironmentVariable("PATH", "$newPath;$currentPath", "User")
}
