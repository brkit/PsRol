BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolItSystemRole' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/itsystem/sys100/systemroles') {
                return @(
                    [PSCustomObject]@{
                        id = 1
                        name = 'Admin Role'
                        identifier = 'ADMIN_ROLE'
                        description = 'Administrator system role'
                        weight = 10
                    },
                    [PSCustomObject]@{
                        id = 2
                        name = 'User Role'
                        identifier = 'USER_ROLE'
                        description = 'User system role'
                        weight = 1
                    }
                )
            }
            return @()
        }
    }

    It 'Should return system roles for a given ItSystemId' {
        $result = Get-RolItSystemRole -ItSystemId 'sys100'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/itsystem/sys100/systemroles' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolSystemRole'
        $result[0].SystemRoleId | Should -Be 1
        $result[0].Name | Should -Be 'Admin Role'
    }

    It 'Should accept pipeline input by property name' {
        $inputObj = [PSCustomObject]@{ ItSystemId = 'sys100' }
        $result = $inputObj | Get-RolItSystemRole

        $result.Count | Should -Be 2
        $result[1].SystemRoleIdentifier | Should -Be 'USER_ROLE'
    }
}
