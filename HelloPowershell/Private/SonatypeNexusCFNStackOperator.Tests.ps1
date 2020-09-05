$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

$PSVersion = $PSVersionTable.PSVersion.Major

Describe "SonatypeNexusCFNStackCreator PS$PSVersion" {

    # Need to set up some mocks here
    [System.Management.Automation.PSModuleInfo]$MockModule =`
        New-Module {
            Mock New-CFNStack { "Hello" }
            function New-SomethingElse { "Something Else" }
        }

    $Creator = [SonatypeNexusCFNStackOperator]::new()
    $Creator.CFNModule = $MockModule

    Context "New-CFNStack" {
        It "Creates a stack" {
            $Creator.NewCFNStack()
            # Should -Invoke $MockModule.ExportedFunctions["New-CFNStack"] -Exactly 1
        }
    }
}
