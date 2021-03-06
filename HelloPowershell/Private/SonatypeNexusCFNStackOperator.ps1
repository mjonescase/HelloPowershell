class SonatypeNexusCFNStackOperator {
    [System.Management.Automation.PSModuleInfo]$CFNModule

    # https://github.com/aws/aws-tools-for-powershell/blob/master/modules/AWSPowerShell/Cmdlets/CloudFormation/Basic/New-CFNStack-Cmdlet.cs#L38
    [Amazon.CloudFormation.Model.CreateStackResponse] NewCFNStack()
    {
        return $this.CFNModule.Invoke({
            Param([string]$Region, [string]$StackName, [string]$TemplateURL)
            New-SomethingElse -Region $Region -StackName $StackName -TemplateURL $TemplateURL
        }, $this.GetRegion(),$this.GetStackName(),$this.GetTemplateURL())
    }

    [string] GetRegion()
    {
        return "us-east-1"
    }

    [string] GetStackName()
    {
        return "SonatypeNexus3-POC"
    }

    [string] GetTemplateURL() 
    {
        return "https://sonatype-cloudformation-templates.s3.amazonaws.com/nexus-repository-manager/1.0.20190607-153709.e76b283/minimal-single-instance.template"
    }
}