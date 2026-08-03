BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'New-RolUserRole' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method, $Body)
            return [PSCustomObject]@{
                id = 999
                name = 'New User Role'
            }
        }
    }

    It 'Should construct payload and POST to /api/v2/userrole' {
        InModuleScope 'PsRol' {
            $constraint = [PsRolConstraintValue]@{
                ConstraintTypeId = 'ct1'
                ConstraintTypeEntityId = 'ent1'
                ConstraintValueType = 'VALUE'
                ConstraintValue = 'val1'
                ConstraintIdentifier = $null
                Postponed = $false
            }
            $sra = [PsRolSystemRoleAssignment]@{
                SystemRoleId = 'sr100'
                ConstraintValues = @($constraint)
            }

            $result = New-RolUserRole -Name 'Test User Role' -Description 'Description' -ItSystemId 'sys100' -SystemRoleAssignment $sra -SensitiveRole

            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq '/api/v2/userrole' -and
                $Method -eq 'POST' -and
                $Body -match '"name"\s*:\s*"Test User Role"' -and
                $Body -match '"itSystemId"\s*:\s*"sys100"' -and
                $Body -match '"sensitiveRole"\s*:\s*true' -and
                $Body -match '"systemRoleId"\s*:\s*"sr100"' -and
                $Body -match '"constraintValue"\s*:\s*"val1"'
            }
            $result.id | Should -Be 999
        }
    }

    It 'Should accept pipeline input by property name for ItSystemId and SystemRoleAssignment' {
        InModuleScope 'PsRol' {
            $sra = [PsRolSystemRoleAssignment]@{
                SystemRoleId = 'sr200'
                ConstraintValues = @()
            }
            $inputObj = [PSCustomObject]@{
                ItSystemId = 'sys200'
                SystemRoleAssignment = @($sra)
            }

            $result = $inputObj | New-RolUserRole -Name 'Pipeline Role' -Description 'Desc'

            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq '/api/v2/userrole' -and
                $Method -eq 'POST' -and
                $Body -match '"itSystemId"\s*:\s*"sys200"' -and
                $Body -match '"systemRoleId"\s*:\s*"sr200"'
            }
        }
    }

    It 'Should respect WhatIf' {
        InModuleScope 'PsRol' {
            $sra = [PsRolSystemRoleAssignment]@{ SystemRoleId = 'sr100'; ConstraintValues = @() }
            New-RolUserRole -Name 'Role' -Description 'Desc' -ItSystemId 'sys1' -SystemRoleAssignment $sra -WhatIf

            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
        }
    }
}
