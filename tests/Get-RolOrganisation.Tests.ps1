BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolOrganisation' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return [PSCustomObject]@{
                orgUnits = @(
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000010'
                        name = 'IT Afdeling'
                        orgUnitId = 'IT01'
                        parentUuid = $null
                    },
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000020'
                        name = 'Økonomi Afdeling'
                        orgUnitId = 'OK01'
                        parentUuid = $null
                    }
                )
            }
        }
    }

    It 'Should call API and return all org units when -Name is omitted' {
        $result = Get-RolOrganisation

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/organisation/v3' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolOrganisation'
        $result[0].Name | Should -Be 'IT Afdeling'
        $result[0].Uuid | Should -BeOfType [guid]
    }

    It 'Should filter organisation units by Name regex match' {
        $result = Get-RolOrganisation -Name 'Økonomi'

        $result.Count | Should -Be 1
        $result[0].Name | Should -Be 'Økonomi Afdeling'
    }

    It 'Should accept pipeline input by property name for Name' {
        $inputObj = [PSCustomObject]@{ Name = 'IT' }
        $result = $inputObj | Get-RolOrganisation

        $result.Count | Should -Be 1
        $result[0].Name | Should -Be 'IT Afdeling'
    }
}
