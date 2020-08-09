if(-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue


InModuleScope 'HelloPowershell' {
    $PSVersion = $PSVersionTable.PSVersion.Major

    $Verbose = @{}
    if($ENV:BHBranchName -notlike "mainline" -or $env:BHCommitMessage -match "!verbose")
    {
        $Verbose.Add("Verbose",$True)
    }

    Describe "Get-Greeting PS$PSVersion" {
        Context 'Gets Greeting' {

            It 'Gets the greeting' {
                # $ENV:BHProjectPath | Should Be "C:\Users\micha\git\HelloPowershell"
                # $ENV:BHProjectName | Should Be "HelloPowershell"
                Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force
                Get-Greeting | Should Be "Hello World!"
            }
        }
    }
}