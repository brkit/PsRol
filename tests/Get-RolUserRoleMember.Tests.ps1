BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolUserRoleMember' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/userrole/ur101/users') {
                return @(
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000001'
                        userId = 'usr01'
                        extUuid = '00000000-0000-0000-0000-000000000010'
                        name = 'Member One'
                        userRole = [PSCustomObject]@{
                            id = 101
                            name = 'Test Role'
                        }
                        assignedThrough = 'DIRECT'
                    }
                )
            }
            return @()
        }
    }

    It 'Should call API and return PsRolUserRoleMember objects' {
        $result = Get-RolUserRoleMember -UserRoleId 'ur101'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole/ur101/users' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 1
        $result[0].GetType().Name | Should -Be 'PsRolUserRoleMember'
        $result[0].UserId | Should -Be 'usr01'
        $result[0].Name | Should -Be 'Member One'
        $result[0].ExtUuid | Should -BeOfType [guid]
    }
}
