BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'New-RolSystemRoleAssignment' {
    It 'Should construct PsRolSystemRoleAssignment object without constraints' {
        $result = New-RolSystemRoleAssignment -SystemRoleId 'sr100'

        $result.GetType().Name | Should -Be 'PsRolSystemRoleAssignment'
        $result.SystemRoleId | Should -Be 'sr100'
        $result.ConstraintValues | Should -BeNullOrEmpty
    }

    It 'Should construct PsRolSystemRoleAssignment object with constraint values' {
        InModuleScope 'PsRol' {
            $constraint = [PsRolConstraintValue]@{
                ConstraintTypeId = 'ct1'
                ConstraintTypeEntityId = 'ent1'
                ConstraintValue = 'val1'
                ConstraintValueType = 'VALUE'
            }
            $result = New-RolSystemRoleAssignment -SystemRoleId 'sr200' -ConstraintValues $constraint

            $result.SystemRoleId | Should -Be 'sr200'
            $result.ConstraintValues.Count | Should -Be 1
            $result.ConstraintValues[0].ConstraintValue | Should -Be 'val1'
        }
    }
}
