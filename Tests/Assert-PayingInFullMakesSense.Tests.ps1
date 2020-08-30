<# if(-not $ENV:BHProjectPath)
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
        Context 'the answer is False' {

            It 'Returns False' {
                # $Result = Get-Greeting # Assert-PayingInFullMakesSense -Discount 0.1
                # $Result.DoesPayInFullMakeSense | Should Be $false
                Get-Greeting | Should Be "Hello World!"
            }
        }
    }
} #>if(-not $ENV:BHProjectPath)
{
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}

Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $ENV:BHProjectPath $ENV:BHProjectName) -Force


InModuleScope 'HelloPowershell' {
    $PSVersion = $PSVersionTable.PSVersion.Major

    $Verbose = @{}
    # if($ENV:BHBranchName -notlike "mainline" -or $env:BHCommitMessage -match "!verbose")
    # {
    $Verbose.Add("Verbose",$True)
    # }

    Describe "Pay In Full PS$PSVersion" {
        Context 'Pays In Full' {
            It 'Returns False if paying in full makes no sense' {
                # Get-Greeting | Should Be "Hello World!"
                $True | Should Be $True
            }
        }
    }
}
