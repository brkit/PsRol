BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolFunction' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    uuid = '00000000-0000-0000-0000-000000000001'
                    name = 'Tillidsmand'
                    description = 'Union representative'
                    itSystem = $null
                    userRoles = @()
                    cvrNumber = '12345678'
                },
                [PSCustomObject]@{
                    uuid = '00000000-0000-0000-0000-000000000002'
                    name = 'Sikkerhedsrepræsentant'
                    description = 'Safety representative'
                    itSystem = $null
                    userRoles = @()
                    cvrNumber = '12345678'
                }
            )
        }
    }

    It 'Should call API and return all functions when -Name is omitted or empty' {
        $result = Get-RolFunction
        
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/function' -and $Method -eq 'GET' }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolFunction'
        $result[0].Name | Should -Be 'Tillidsmand'
        $result[0].uuid | Should -BeOfType [guid]
    }

    It 'Should filter functions by Name wildcard' {
        $result = Get-RolFunction -Name '*Sikkerhed*'
        
        $result.Count | Should -Be 1
        $result[0].Name | Should -Be 'Sikkerhedsrepræsentant'
    }

    It 'Should return empty array when no function matches Name' {
        $result = Get-RolFunction -Name 'NonExistentFunction'
        
        $result | Should -BeNullOrEmpty
    }
}
