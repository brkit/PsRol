BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolOrganisation' {
    BeforeEach {
        & (Get-Module PsRol) {
            $Script:OrganisationCache = $null
            $Script:OrganisationCacheTime = $null
            $Script:OrganisationCacheTimeoutSeconds = 300
        }

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

    It 'Should cache results on subsequent calls within timeout and not call API again' {
        $result1 = Get-RolOrganisation
        $result2 = Get-RolOrganisation

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1
        $result1.Count | Should -Be 2
        $result2.Count | Should -Be 2
    }

    It 'Should refresh cache after cache timeout expires' {
        $result1 = Get-RolOrganisation

        & (Get-Module PsRol) {
            $Script:OrganisationCacheTime = (Get-Date).AddSeconds(-301)
        }

        $result2 = Get-RolOrganisation

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2
    }

    It 'Should respect module author configured OrganisationCacheTimeoutSeconds' {
        & (Get-Module PsRol) {
            $Script:OrganisationCacheTimeoutSeconds = 10
        }

        $result1 = Get-RolOrganisation

        & (Get-Module PsRol) {
            $Script:OrganisationCacheTime = (Get-Date).AddSeconds(-11)
        }

        $result2 = Get-RolOrganisation

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2
    }
}
