BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Add-RolOrgUnitAssignRoleGroup' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {}
    }

    It 'Should send correct payload to organisation assignment rolegroup endpoint' {
        $startDate = Get-Date
        $expectedDate = $startDate.ToString('yyyy-MM-dd')

        Add-RolOrgUnitAssignRoleGroup -RoleGroupId 100 -OrgUnitUuid '00000000-0000-0000-0000-000000000001' -StartDate $startDate -Inherit

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/organisation/assignment/rolegroup' -and
            $Method -eq 'POST' -and
            $Body -match '"assignmentType"\s*:\s*"ROLE_GROUP"' -and
            $Body -match '"inherit"\s*:\s*true' -and
            $Body -match '"uuid"\s*:\s*"00000000-0000-0000-0000-000000000001"' -and
            $Body -match '"id"\s*:\s*"100"' -and
            $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedDate)
        }
    }

    It 'Should pass stopDate and scopes correctly when supplied' {
        InModuleScope 'PsRol' {
            $startDate = Get-Date
            $stopDate = $startDate.AddMonths(6)
            $expectedStart = $startDate.ToString('yyyy-MM-dd')
            $expectedStop = $stopDate.ToString('yyyy-MM-dd')

            $scope = [PsRolAssignmentScope]@{ type = 'MANAGER'; manager = $true; substitute = $false }
            Add-RolOrgUnitAssignRoleGroup -RoleGroupId 200 -OrgUnitUuid '00000000-0000-0000-0000-000000000002' -StartDate $startDate -StopDate $stopDate -Scope $scope
            
            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq '/api/v2/organisation/assignment/rolegroup' -and
                $Method -eq 'POST' -and
                $Body -match '"inherit"\s*:\s*false' -and
                $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedStart) -and
                $Body -match ('"stopDate"\s*:\s*"{0}"' -f $expectedStop)
            }
        }
    }

    It 'Should respect WhatIf' {
        Add-RolOrgUnitAssignRoleGroup -RoleGroupId 100 -OrgUnitUuid '00000000-0000-0000-0000-000000000003' -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
    }
}
