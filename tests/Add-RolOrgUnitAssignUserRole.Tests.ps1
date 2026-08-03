BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Add-RolOrgUnitAssignUserRole' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {}
    }

    It 'Should send correct payload to organisation assignment userrole endpoint' {
        $startDate = Get-Date
        $expectedDate = $startDate.ToString('yyyy-MM-dd')

        Add-RolOrgUnitAssignUserRole -UserRoleId 500 -OrgUnitUuid '00000000-0000-0000-0000-000000000001' -StartDate $startDate -Inherit

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/organisation/assignment/userrole' -and
            $Method -eq 'POST' -and
            $Body -match '"assignmentType"\s*:\s*"USER_ROLE"' -and
            $Body -match '"inherit"\s*:\s*true' -and
            $Body -match '"uuid"\s*:\s*"00000000-0000-0000-0000-000000000001"' -and
            $Body -match '"id"\s*:\s*"500"' -and
            $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedDate)
        }
    }

    It 'Should pass stopDate correctly when supplied' {
        $startDate = Get-Date
        $stopDate = $startDate.AddDays(14)
        $expectedStart = $startDate.ToString('yyyy-MM-dd')
        $expectedStop = $stopDate.ToString('yyyy-MM-dd')

        Add-RolOrgUnitAssignUserRole -UserRoleId 600 -OrgUnitUuid '00000000-0000-0000-0000-000000000002' -StartDate $startDate -StopDate $stopDate

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/organisation/assignment/userrole' -and
            $Method -eq 'POST' -and
            $Body -match '"inherit"\s*:\s*false' -and
            $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedStart) -and
            $Body -match ('"stopDate"\s*:\s*"{0}"' -f $expectedStop)
        }
    }

    It 'Should respect WhatIf' {
        Add-RolOrgUnitAssignUserRole -UserRoleId 500 -OrgUnitUuid '00000000-0000-0000-0000-000000000003' -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
    }
}
