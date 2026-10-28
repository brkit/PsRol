BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolRoleGroup' {
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
                    approverPermission = @('INHERIT')
                    requesterPermission = @('INHERIT')
                }
            )
        }
    }

    It 'Should call the API and return formatted role groups' {
        InModuleScope 'PsRol' {
            $result = Get-RolRoleGroup
            
            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/rolegroup' -and $Method -eq 'Get' }
            
            $result.Count | Should -Be 1
            $result[0].RoleGroupId | Should -Be 'group1'
            $result[0].Name | Should -Be 'Test Group 1'
            $result[0].UserRoles.Count | Should -Be 1
            $result[0].UserRoles[0].UserRoleId | Should -Be 'ur1'
            $result[0].ApproverPermission.Count | Should -Be 1
            $result[0].ApproverPermission[0] | Should -Be ([PsRolApproverPermission]::INHERIT)
            $result[0].ApproverPermission[0].GetType().Name | Should -Be 'PsRolApproverPermission'
            $result[0].RequesterPermission.Count | Should -Be 1
            $result[0].RequesterPermission[0] | Should -Be ([PsRolRequesterPermission]::INHERIT)
            $result[0].RequesterPermission[0].GetType().Name | Should -Be 'PsRolRequesterPermission'
        }
    }

    It 'Should return Name when ToString is called on PsRolRoleGroup' {
        $result = Get-RolRoleGroup
        $result[0].ToString() | Should -Be 'Test Group 1'
    }

    Context 'Permission Enum Mapping' {
        It 'Should correctly map multiple approverPermission and requesterPermission enum values' {
            InModuleScope 'PsRol' {
                $obj = [PSCustomObject]@{
                    id = 'group2'
                    name = 'Multi Perm Group'
                    approverPermission = @('AUTOMATIC', 'MANAGERORSUBSTITUTE')
                    requesterPermission = @('EMPLOYEE', 'ADMIN')
                }
                $roleGroup = [PsRolRoleGroup]::new($obj)

                $roleGroup.ApproverPermission.Count | Should -Be 2
                $roleGroup.ApproverPermission[0] | Should -Be ([PsRolApproverPermission]::AUTOMATIC)
                $roleGroup.ApproverPermission[1] | Should -Be ([PsRolApproverPermission]::MANAGERORSUBSTITUTE)
                $roleGroup.ApproverPermission[0].GetType().Name | Should -Be 'PsRolApproverPermission'
                $roleGroup.RequesterPermission.Count | Should -Be 2
                $roleGroup.RequesterPermission[0] | Should -Be ([PsRolRequesterPermission]::EMPLOYEE)
                $roleGroup.RequesterPermission[1] | Should -Be ([PsRolRequesterPermission]::ADMIN)
                $roleGroup.RequesterPermission[0].GetType().Name | Should -Be 'PsRolRequesterPermission'
            }
        }

        It 'Should leave ApproverPermission and RequesterPermission null when not present' {
            InModuleScope 'PsRol' {
                $obj = [PSCustomObject]@{
                    id = 'group3'
                    name = 'No Perm Group'
                }
                $roleGroup = [PsRolRoleGroup]::new($obj)

                $roleGroup.ApproverPermission | Should -BeNullOrEmpty
                $roleGroup.RequesterPermission | Should -BeNullOrEmpty
            }
        }
    }
}
