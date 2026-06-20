param(
    [string]$item,
    [switch]$dryrun
)

if (-not $item) {
    Write-Host "Usage: link -item <path> [-dryrun]"
    exit 1
}

$original = Resolve-Path ".\$item"
$target = Join-Path $HOME $item

Write-Host "linking $original to $target"

if ($dryrun) { exit 0 }

Write-Host "linked"

if (Test-Path $original -PathType Container) {
    New-Item -ItemType Junction -Path $target -Target $original -ErrorAction Ignore
} else {
    New-Item -ItemType HardLink -Path $target -Target $original -ErrorAction Ignore
}
