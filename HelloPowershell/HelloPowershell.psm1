# Get public and private function definition files.
[System.Object[]] $Public = Get-ChildItem $(Join-Path HelloPowershell Public) -Filter *.ps1
[System.Object[]] $Private = Get-ChildItem $(Join-Path HelloPowershell Private) -Filter *.ps1

`n`t"Private file names: $Private"
`n`t"Public file names: $Public"

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