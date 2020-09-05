$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

$PSVersion = $PSVersionTable.PSVersion.Major

# Need to set up some mocks here
[System.Management.Automation.PSModuleInfo]$MockModule =`
    New-Module {
        function New-CFNStack {
            
        }
    }

$Creator = [SonatypeNexusCFNStackOperator]::new()
$Creator.CFNModule = $MockModule

Describe "SonatypeNexusCFNStackCreator PS$PSVersion" {
    Context "New-CFNStack" {
        It "Creates a stack" {
            $Creator.NewCFNStack()
        }
    }
}
