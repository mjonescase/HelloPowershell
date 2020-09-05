Function New-SonatypeNexusCFNStack {
    <#
    .SYNOPSIS
        Passthrough to New-CFNStack

    .DESCRIPTION
        Creates a new CloudFormation stack like the one in this Quickstart guide:
        https://guides.sonatype.com/repo3/quick-start-guides/aws-for-repo/

    .PARAMETER Region
        AWS region in which to deploy the stack. Defaults to us-east-1

    .PARAMETER StackName
        Name of the CloudFormation stack. Defaults to SonatypeNexus3-POC

    .EXAMPLE
        New-SonatypeNexusCFNStack -Region us-west-2 -StackName MyVeryOwnStack

    .LINK
        about_New-SonatypeNexusCFNStack

    .LINK
        https://github.com/mjonescase/HelloPowershell
    #>
    [cmdletbinding()]
    Param(
        [Parameter(
            Mandatory = $false,
            Position = 0
        )]
        [string]$Region = "us-east-1",

        [Parameter(
            Mandatory = $false,
            Position = 1
        )]
        [string]$StackName = "SonatypeNexus3-POC"
    )
    <#
        This function is my **driver**, my main. I should define a class in Private\ that
        takes all the arguments from the user, plus the New-CFNStack cmdlet. I can unit test that.
    #>
    # TODO figure out how to inject New-CFNStack
}