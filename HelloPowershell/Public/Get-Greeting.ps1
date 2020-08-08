Function Get-Greeting {
    <#
    .SYNOPSIS
        Returns a greeting string.

    .DESCRIPTION
        Returns a greeting string.

        It's hardcoded to "Hello World!"

    .EXAMPLE
        Get-Greeting # Returns "Hello World!"

    .LINK
        about_Get-Greeting

    .LINK
        https://github.com/mjonescase/HelloPowershell

    #>
    [cmdletbinding()]
    Param()
    "Hello World!"
}