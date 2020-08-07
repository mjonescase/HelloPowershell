@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        Target = '$ENV:USERPROFILE\Documents\WindowsPowerShell\Modules'
        AddToPath = $true
        <# Parameters = @{
            Force = $True
        } #>
    }

    # Grab some modules without depending on PowerShellGet
    'psake' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
    }

    'PSDeploy' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
    }

    'BuildHelpers' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
    }

    'Pester' = @{
        DependencyType = 'PSGalleryNuget'
        Version = '3.4.6'
        Force = $true
    }

    # Module dependencies for Azure-related deployment types
    'Az.Resources' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
        DependsOn = 'UninstallAzureRM'
    }

    'Az.Automation' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
        DependsOn = 'UninstallAzureRM'
    }

    'Az.Storage' = @{
        DependencyType = 'Command'
        Source = '
        if($env:APPVEYOR) {
            $azureRMModules = Get-Module -Name AzureRM* -ListAvailable
            $azureRMModules += Get-Module -Name Azure.* -ListAvailable
            if ($azureRMModules) {
                foreach ($module in $azureRMModules | Get-Unique) {
                    Write-Verbose "Uninstalling module $($module.Name) version $($module.Version)..."
                    Uninstall-module $module.Name
                }
            }
        }
        '
    }
}