if(-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force


InModuleScope 'HelloPowershell' {
    $PSVersion = $PSVersionTable.PSVersion.Major

    $Verbose = @{}
    if($ENV:BHBranchName -notlike "mainline" -or $env:BHCommitMessage -match "!verbose")
    {
        $Verbose.Add("Verbose",$True)
    }

    Describe "Get-Greeting PS$PSVersion" {

        Context 'This test will fail 2' {

            It 'Fails' {
                $True | Should Be $False
            }
        }

        Context 'Gets Greeting' {

            It 'Gets the greeting' {
                Get-Greeting | Should Be "Hello World!"
            }
        }
    }
}