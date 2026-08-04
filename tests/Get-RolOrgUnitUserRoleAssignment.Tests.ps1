BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolOrgUnitUserRoleAssignment' {
    BeforeEach {
        Mock -CommandName Get-RolOrganisation -ModuleName PsRol -MockWith {
            param($Name)
            if ($Name -eq 'Test OrgUnit') {
                return @(
                    [PSCustomObject]@{
                        uuid = '00000000-0000-0000-0000-000000000001'
                        name = 'Test OrgUnit'
                    }
                )
            }
            return @()
        }

        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/organisation/00000000-0000-0000-0000-000000000001/assignment/userrole' -and $Method -eq 'GET') {
                return @(
                    [PSCustomObject]@{
                        assignmentType   = 'USER_ROLE'
                        assignedAt       = '2026-08-04T14:34:17'
                        assignedByName   = 'Test User'
                        assignedByUserId = 'user01'
                        assignmentId     = 1328
                        inherit          = $false
                        orgUnit          = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            name = 'Test OrgUnit'
                        }
                        scopes           = @()
                        startDate        = $null
                        stopDate         = $null
                        userRole         = [PSCustomObject]@{
                            id         = 185140
                            identifier = '00000000-0000-0000-0000-000000000002'
                            name       = 'Test UserRole'
                        }
                    }
                )
            }
            return @()
        }
    }

    It 'Should call API directly when OrgUnitUuid is provided' {
        $result = Get-RolOrgUnitUserRoleAssignment -OrgUnitUuid '00000000-0000-0000-0000-000000000001'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/organisation/00000000-0000-0000-0000-000000000001/assignment/userrole' -and $Method -eq 'GET'
        }
        $result.Count | Should -Be 1
        $result[0].GetType().Name | Should -Be 'PsRolOrgUnitUserRoleAssignment'
        $result[0].AssignmentId | Should -Be 1328
        $result[0].AssignmentType | Should -Be 'USER_ROLE'
        $result[0].AssignedByName | Should -Be 'Test User'
        $result[0].AssignedByUserId | Should -Be 'user01'
        $result[0].Inherit | Should -Be $false
        $result[0].OrgUnit.Name | Should -Be 'Test OrgUnit'
        $result[0].OrgUnit.Uuid.ToString() | Should -Be '00000000-0000-0000-0000-000000000001'
        $result[0].UserRole.UserRoleId | Should -Be 185140
        $result[0].UserRole.Name | Should -Be 'Test UserRole'
    }

    It 'Should resolve OrgUnit by Name and then call API' {
        $result = Get-RolOrgUnitUserRoleAssignment -OrgUnitName 'Test OrgUnit'

        Should -Invoke -CommandName Get-RolOrganisation -ModuleName PsRol -Times 1
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1
        $result.Count | Should -Be 1
        $result[0].GetType().Name | Should -Be 'PsRolOrgUnitUserRoleAssignment'
    }

    It 'Should accept non-GUID string via OrgUnitUuid parameter and resolve via Get-RolOrganisation' {
        $result = Get-RolOrgUnitUserRoleAssignment -OrgUnitUuid 'Test OrgUnit'

        Should -Invoke -CommandName Get-RolOrganisation -ModuleName PsRol -Times 1
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1
        $result.Count | Should -Be 1
    }

    It 'Should accept OrgUnitUuid from pipeline' {
        $result = '00000000-0000-0000-0000-000000000001' | Get-RolOrgUnitUserRoleAssignment

        $result.Count | Should -Be 1
        $result[0].AssignmentId | Should -Be 1328
    }

    It 'Should accept organisation object pipeline input by property binding (Uuid)' {
        $org = [PSCustomObject]@{
            uuid = '00000000-0000-0000-0000-000000000001'
            name = 'Test OrgUnit'
        }
        $result = $org | Get-RolOrgUnitUserRoleAssignment

        $result.Count | Should -Be 1
        $result[0].AssignmentId | Should -Be 1328
    }
}
