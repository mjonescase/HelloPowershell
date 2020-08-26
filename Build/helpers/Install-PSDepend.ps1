<#
.SYNOPSIS
    Bootstrap PSDepend

.DESCRIPTION
    Bootstrap PSDepend

    Why? No reliance on PowerShellGallery

     * Downloads nuget to $NugetPath
     * Creates $Path (and full path to it)
     * Downloads module to $Path\PSDepend
     
.PARAMETER NugetPath
    Desired nuget.exe install location

.PARAMETER Path
    Module path to install PSDepend

    Defaults to the first option in the PSModulePath environment variable

.EXAMPLE
    .\Install-PSDepend.ps1 -Path C:\Modules

    # Installs to C:\Modules\PSDepend
#>
[cmdletbinding()]
param(
    [string]$Path = $($env:PSModulePath.Split(";")[0]),
    [string]$NugetPath
)

$ExistingProgressPreference = "$ProgressPreference"
$ProgressPreference = 'SilentlyContinue'
$NugetFilePath = Join-Path $NugetPath "nuget.exe"
try {
    # Bootstrap nuget
    If (-not (Test-Path $NugetPath -PathType Container) )
    {
        If (Test-Path $NugetPath -PathType Leaf)
        {
            Write-Error "$NugetPath already exists as a file. Could not create directory."
        }

        New-Item -ItemType Container -Path $NugetPath
    }

    if(-not (Test-Path $NugetFilePath)) {
        Write-Output "Installing NuGet to $NugetFilePath"
        Invoke-WebRequest -uri 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile $NugetFilePath
    }
    
    # Bootstrap PSDepend, re-use nuget.exe for the module
    if($path) { $null = mkdir $path -Force }
    $NugetParams = 'install', 'PSDepend', '-Source', 'https://www.powershellgallery.com/api/v2',
                '-ExcludeVersion', '-NonInteractive', '-OutputDirectory', $Path
    & $NugetFilePath @NugetParams
}
finally {
    $ProgressPreference = $ExistingProgressPreference
}
