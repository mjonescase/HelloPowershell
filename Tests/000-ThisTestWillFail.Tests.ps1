Describe "Failing-Test PS$PSVersion" {
    Context 'This test will fail' {
        It 'Fails' {
            $True | Should Be $False
        }
    }
}