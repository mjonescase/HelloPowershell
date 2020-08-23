param(
    $Task = 'Default',
    $DependencyInstallDestination = ".PSDependModules"
)

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
if(-not (Get-Module -ListAvailable PSDepend))
{
    & (Resolve-Path "$PSScriptRoot\helpers\Install-PSDepend.ps1") -Path $DependencyInstallDestination
}

Import-Module PSDepend 
# $null = Invoke-PSDepend -Path "$PSScriptRoot\build.requirements.psd1" -Install -Import -Force

# Set-BuildEnvironment -Force

# Invoke-psake $PSScriptRoot\psake.ps1 -taskList $Task -nologo
# exit ( [int]( -not $psake.build_success ) )
