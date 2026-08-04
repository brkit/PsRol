BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolOrgUnitRoleGroupAssignment' {
    BeforeEach {
        Mock -CommandName Get-RolOrganisation -ModuleName PsRol -MockWith {
            param($Name)
            if ($Name -eq 'Digitalisering') {
                return @(
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000001'
                        name = 'Digitalisering'
                    }
                )
            }
            return @()
        }

        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/organisation/00000000-0000-0000-0000-000000000001/assignment/rolegroup' -and $Method -eq 'GET') {
                return @(
                    [PSCustomObject]@{
                        assignmentType   = 'ROLE_GROUP'
                        assignedAt       = '2026-07-29T11:57:52'
                        assignedByName   = 'Test User'
                        assignedByUserId = 'user01'
                        assignmentId     = 43
                        inherit          = $false
                        orgUnit          = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            name = 'Digitalisering'
                        }
                        roleGroup        = [PSCustomObject]@{
                            id   = 111
                            name = 'RoleGroup_Digitalisering_Informationssikkerhedskonsulent'
                        }
                        scopes           = @(
                            [PSCustomObject]@{
                                type   = 'TITLE'
                                titles = @(
                                    [PSCustomObject]@{
                                        uuid = '00000000-0000-0000-0000-000000000002'
                                        name = 'Informationssikkerhedskonsulent'
                                    }
                                )
                            }
                        )
                        startDate        = $null
                        stopDate         = $null
                    },
                    [PSCustomObject]@{
                        assignmentType   = 'ROLE_GROUP'
                        assignedAt       = '2026-04-28T11:17:53'
                        assignedByName   = 'Test User'
                        assignedByUserId = 'user01'
                        assignmentId     = 63
                        inherit          = $false
                        orgUnit          = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            name = 'Digitalisering'
                        }
                        roleGroup        = [PSCustomObject]@{
                            id   = 92
                            name = 'RoleGroup_Digitalisering_Digitaliseringskonsulent'
                        }
                        scopes           = @(
                            [PSCustomObject]@{
                                type   = 'TITLE'
                                titles = @(
                                    [PSCustomObject]@{
                                        uuid = '00000000-0000-0000-0000-000000000003'
                                        name = 'Digitaliseringskonsulent'
                                    }
                                )
                            }
                        )
                        startDate        = $null
                        stopDate         = $null
                    }
                )
            }
            return @()
        }
    }

    It 'Should call API directly when OrgUnitUuid is provided' {
        $result = Get-RolOrgUnitRoleGroupAssignment -OrgUnitUuid '00000000-0000-0000-0000-000000000001'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/organisation/00000000-0000-0000-0000-000000000001/assignment/rolegroup' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolOrgUnitRoleGroupAssignment'
        $result[0].AssignmentId | Should -Be 43
        $result[0].AssignmentType | Should -Be 'ROLE_GROUP'
        $result[0].AssignedByName | Should -Be 'Test User'
        $result[0].RoleGroup.RoleGroupId | Should -Be '111'
        $result[0].RoleGroup.Name | Should -Be 'RoleGroup_Digitalisering_Informationssikkerhedskonsulent'
        $result[0].Scopes.Count | Should -Be 1
        $result[0].Scopes[0].GetType().Name | Should -Be 'PsRolAssignmentScope'
        $result[0].Scopes[0].titles[0].name | Should -Be 'Informationssikkerhedskonsulent'
    }

    It 'Should resolve OrgUnit by Name and then call API' {
        $result = Get-RolOrgUnitRoleGroupAssignment -OrgUnitName 'Digitalisering'

        Should -Invoke -CommandName Get-RolOrganisation -ModuleName PsRol -Times 1
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1
        $result.Count | Should -Be 2
        $result[0].GetType().Name | Should -Be 'PsRolOrgUnitRoleGroupAssignment'
    }

    It 'Should accept non-GUID string via OrgUnitUuid parameter and resolve via Get-RolOrganisation' {
        $result = Get-RolOrgUnitRoleGroupAssignment -OrgUnitUuid 'Digitalisering'

        Should -Invoke -CommandName Get-RolOrganisation -ModuleName PsRol -Times 1
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1
        $result.Count | Should -Be 2
    }

    It 'Should accept OrgUnitUuid from pipeline' {
        $result = '00000000-0000-0000-0000-000000000001' | Get-RolOrgUnitRoleGroupAssignment

        $result.Count | Should -Be 2
        $result[0].AssignmentId | Should -Be 43
    }

    It 'Should accept organisation object pipeline input by property binding (Uuid)' {
        $org = [PSCustomObject]@{
            uuid = '00000000-0000-0000-0000-000000000001'
            name = 'Digitalisering'
        }
        $result = $org | Get-RolOrgUnitRoleGroupAssignment

        $result.Count | Should -Be 2
        $result[0].AssignmentId | Should -Be 43
    }
}
