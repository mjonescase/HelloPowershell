# Get public and private function definition files.

$PrivateDir = $(Resolve-Path $(Join-Path .\HelloPowershell Private)).Path
$PublicDir = $(Resolve-Path $(Join-Path .\HelloPowershell Public)).Path

[System.Object[]] $Public = Get-ChildItem $PublicDir -Filter *.ps1
[System.Object[]] $Private = Get-ChildItem $PrivateDir -Filter *.ps1
[string[]]$PrivateModules = Get-ChildItem $PSScriptRoot\Private -ErrorAction SilentlyContinue |
    Where-Object {$_.PSIsContainer} |
    Select-Object -ExpandProperty FullName

if ($Private.Count -eq 0)
{
    Write-Error "Didn't find any private .ps1 files. Looked in $PrivateDir"
}

# Dot source the files
Foreach($import in @($Public + $Private))
{
    try {
        . $import.fullname
    }
    catch {
        Write-Error "Failed to import the function $($import.fullname): $_"
    }
}

# Load up dependency modules
foreach($Module in $PrivateModules)
{
    try {
        Import-Module $Module -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to import module $Module`: $_"
    }
}