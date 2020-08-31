param(
    $Task = 'Default',
    $DependencyInstallDestination = ".PSDependModules",
    $NugetPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(".\bin"),
    [switch]$Local
)

Write-Output "NugetPath: $NugetPath. Adding to `$PATH..."
$env:PATH="$env:PATH;$NugetPath"
Write-Output "Local is set to $Local"

# create .PSDependModules if it doesn't exist
if (Test-Path $DependencyInstallDestination -PathType Container)
{
    # if it already exists as a file, throw an error
    if (Test-Path $DependencyInstallDestination -PathType Leaf)
    {
        Write-Error "PSDepend dependency install directory supplied already exists as a file - $(Resolve-Path $DependencyInstallDestination)"
    }
} else {
    New-Item -ItemType Container -Name $DependencyInstallDestination
}

# dependencies
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
if(( -not (Get-Module -ListAvailable PSDepend )) -or $Local)
{
    Write-Output "Installing PSDepend and NuGet..."
    & (Resolve-Path "$PSScriptRoot\helpers\Install-PSDepend.ps1") -Path $DependencyInstallDestination -NugetPath $NugetPath
}

if (-not (Get-Command 'nuget' -ErrorAction SilentlyContinue).Path)
{
    Write-Error "nuget was not installed and put into PATH properly."
    Exit 1
}

Import-Module .\.PSDependModules\PSDepend -Verbose

$null = Invoke-PSDepend -Path "$PSScriptRoot\build.requirements.psd1" -Install -Import -Force

Set-BuildEnvironment -Force

Invoke-psake $PSScriptRoot\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )
