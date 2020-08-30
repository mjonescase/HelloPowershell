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
        $Verbose.Add("Verbose", $True)
    }

    Describe "Assert-PayingInFullMakesSense PS$PSVersion" {
        Context 'This test will fail' {
            It 'Fails' {
                $True | Should Be $False
            }
        }

        Context 'the answer is False' {
            It 'Returns False' {
                $Result = Assert-PayingInFullMakesSense -Discount 0.1
                $Result.DoesPayInFullMakeSense | Should Be $false
                
            }
        }
    }
}
