$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = $PSScriptRoot
$out = Join-Path $root 'Hx4Diva.zip'
$exclude = @('runtime/Hx4Diva/MMPlusMods')

if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Force }

$files = git -c core.quotepath=off ls-files --cached --others --exclude-standard
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Failed to list files. Is this folder a git repo?'
    exit 1
}

$zip = [System.IO.Compression.ZipFile]::Open($out, 'Create')
$added = 0
try {
    foreach ($f in $files) {
        if ([string]::IsNullOrWhiteSpace($f)) { continue }
        if ($exclude -contains $f) { continue }
        $full = Join-Path $root $f
        if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
            Write-Host "Skipping (not a file): $f"
            continue
        }
        
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $full, ($f -replace '\\', '/'), 'Optimal') | Out-Null
        $added++
    }
}
finally {
    $zip.Dispose()
}

Write-Host "Created Hx4Diva.zip with $added files."
if ($added -eq 0) { Write-Host 'Nothing was added, not submitting.'; exit 1 }

haxelib submit Hx4Diva.zip