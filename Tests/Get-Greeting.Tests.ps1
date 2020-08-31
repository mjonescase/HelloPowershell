if(-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force


InModuleScope 'HelloPowershell' {
    $PSVersion = $PSVersionTable.PSVersion.Major

    Describe "Get-Greeting PS$PSVersion" {
        Context 'Gets Greeting' {
            It 'Gets the greeting' {
                Get-Greeting | Should -Be "Hello World!"
            }
        }
    }
}