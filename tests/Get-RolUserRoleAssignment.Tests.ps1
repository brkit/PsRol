BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolUserRoleAssignment' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -like '/api/v2/user/usr01/assignments*') {
                return @(
                    [PSCustomObject]@{
                        user                 = [PSCustomObject]@{
                            uuid    = '00000000-0000-0000-0000-000000000001'
                            userId  = 'usr01'
                            extUuid = '00000000-0000-0000-0000-000000000010'
                            name    = 'Test User'
                        }
                        userRole             = [PSCustomObject]@{
                            id            = 101
                            name          = 'Test Role'
                            identifier    = 'ROLE-01'
                            description   = 'Test Role Description'
                            sensitiveRole = $false
                            itSystemId    = 5
                        }
                        responsibleOrgUnit   = [PSCustomObject]@{
                            name = 'Center for Test'
                            uuid = '00000000-0000-0000-0000-000000000100'
                        }
                        assignedThroughTitle = [PSCustomObject]@{
                            name = 'Konsulent'
                            uuid = '00000000-0000-0000-0000-000000000200'
                        }
                        postponedConstraints = @(
                            [PSCustomObject]@{
                                value                  = '123'
                                constraintTypeId       = 61
                                constraintTypeEntityId = 'org-entity'
                                systemRoleId           = 10
                            }
                        )
                        assignedThrough      = 'DIRECT'
                    }
                )
            }
            return @()
        }
    }

    It 'Should call API and return PsRolUserRoleAssignment objects with mapped properties' {
        $result = Get-RolUserRoleAssignment -UserId 'usr01'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/usr01/assignments' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 1
        $result[0].GetType().Name | Should -Be 'PsRolUserRoleAssignment'
        $result[0].User.GetType().Name | Should -Be 'PsRolUser'
        $result[0].User.UserId | Should -Be 'usr01'
        $result[0].User.ToString() | Should -Be 'Test User (usr01)'
        $result[0].User.Name | Should -Be 'Test User'
        $result[0].UserRole.GetType().Name | Should -Be 'PsRolUserRole'
        $result[0].UserRole.Id | Should -Be 101
        $result[0].UserRole.Name | Should -Be 'Test Role'
        $result[0].ResponsibleOrgUnit.GetType().Name | Should -Be 'PsRolOrganisation'
        $result[0].ResponsibleOrgUnit.Name | Should -Be 'Center for Test'
        $result[0].AssignedThroughTitle.GetType().Name | Should -Be 'PsRolTitle'
        $result[0].AssignedThroughTitle.name | Should -Be 'Konsulent'
        $result[0].PostponedConstraints.Count | Should -Be 1
        $result[0].PostponedConstraints[0].GetType().Name | Should -Be 'PsRolPostponedConstraint'
        $result[0].PostponedConstraints[0].Value | Should -Be '123'
        $result[0].AssignedThrough | Should -Be 'DIRECT'
    }

    It 'Should include System query parameter when specified' {
        $result = Get-RolUserRoleAssignment -UserId 'usr01' -System 'sys01'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/usr01/assignments?system=sys01' -and $Method -eq 'GET'
        }
    }

    It 'Should include Domain query parameter when specified' {
        $result = Get-RolUserRoleAssignment -UserId 'usr01' -Domain 'Skole'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/usr01/assignments?domain=Skole' -and $Method -eq 'GET'
        }
    }

    It 'Should include both System and Domain query parameters when specified' {
        $result = Get-RolUserRoleAssignment -UserId 'usr01' -System 'sys01' -Domain 'Skole'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/usr01/assignments?system=sys01&domain=Skole' -and $Method -eq 'GET'
        }
    }

    It 'Should accept UserId from pipeline' {
        $result = 'usr01' | Get-RolUserRoleAssignment

        $result.Count | Should -Be 1
        $result[0].User.UserId | Should -Be 'usr01'
    }

    It 'Should accept UserId by property name from pipeline' {
        $result = [PSCustomObject]@{ UserId = 'usr01' } | Get-RolUserRoleAssignment

        $result.Count | Should -Be 1
        $result[0].User.UserId | Should -Be 'usr01'
    }

    It 'Should return empty result when user has no assignments' {
        $result = Get-RolUserRoleAssignment -UserId 'nonexistent'

        $result | Should -BeNullOrEmpty
    }
}
