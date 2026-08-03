BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolTitle' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    uuid = '00000000-0000-0000-0000-000000000001'
                    name = 'Lærer'
                },
                [PSCustomObject]@{
                    uuid = '00000000-0000-0000-0000-000000000002'
                    name = 'Pædagog'
                }
            )
        }
    }

    It 'Should call API and return all titles when -Name is omitted' {
        $result = Get-RolTitle

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/title' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolTitle'
        $result[0].Name | Should -Be 'Lærer'
    }

    It 'Should filter titles by Name wildcard' {
        $result = Get-RolTitle -Name '*dagog*'

        $result.Count | Should -Be 1
        $result[0].Name | Should -Be 'Pædagog'
    }

    It 'Should return empty array when no title matches Name' {
        $result = Get-RolTitle -Name 'NonExistentTitle'

        $result | Should -BeNullOrEmpty
    }
}
