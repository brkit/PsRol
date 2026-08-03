BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolRoleGroupMember' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/rolegroup/rg100/users') {
                return @(
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000001'
                        userId = 'user01'
                        extUuid = '00000000-0000-0000-0000-000000000010'
                        name = 'User One'
                    },
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000002'
                        userId = 'user02'
                        extUuid = '00000000-0000-0000-0000-000000000020'
                        name = 'User Two'
                    }
                )
            }
            return @()
        }
    }

    It 'Should call API endpoint and return PsRolUser objects' {
        $result = Get-RolRoleGroupMember -RoleGroupId 'rg100'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/rolegroup/rg100/users' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolUser'
        $result[0].UserId | Should -Be 'user01'
        $result[0].Name | Should -Be 'User One'
        $result[1].UserId | Should -Be 'user02'
    }
}
