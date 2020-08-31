@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        Target = '.\.PSDependModules'
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

    'BuildHelpers' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
    }

    'Pester' = @{
        DependencyType = 'PSGalleryNuget'
        Force = $true
    }
}