BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe "Get-RolRoleGroup" {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    id = 'group1'
                    name = 'Test Group 1'
                    description = 'Description 1'
                    usersOnly = $true
                    canRequest = $false
                    userRoles = @(
                        [PSCustomObject]@{
                            userRoleId = 'ur1'
                            assignedByUserId = 'u1'
                            assignedByName = 'User 1'
                            assignedTimestamp = '2023-01-01T00:00:00Z'
                        }
                    )
                }
            )
        }
    }

    It "Should call the API and return formatted role groups" {
        $result = Get-RolRoleGroup
        
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/rolegroup' -and $Method -eq 'Get' }
        
        $result.Count | Should -Be 1
        $result[0].RoleGroupId | Should -Be 'group1'
        $result[0].Name | Should -Be 'Test Group 1'
        $result[0].UserRoles.Count | Should -Be 1
        $result[0].UserRoles[0].UserRoleId | Should -Be 'ur1'
    }
}
