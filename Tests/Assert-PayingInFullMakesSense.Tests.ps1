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
        $Verbose.Add("Verbose", $True)
    }

    Describe "Assert-PayingInFullMakesSense PS$PSVersion" {
        Context 'the answer is False' {
            It 'Returns False' {
                Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force
                Assert-PayingInFullMakesSense | Should Be $false
            }
        }
    }
}