BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'New-RolConstraintValue' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/constraint/ct-100') {
                return [PSCustomObject]@{
                    id       = 'ct-100'
                    entityId = 'entity-100'
                    regex    = '^[0-9]{4}$'
                }
            }
            if ($Uri -eq '/api/v2/constraint') {
                return @(
                    [PSCustomObject]@{
                        id       = 'ct-200'
                        entityId = 'entity-200'
                        regex    = '^[a-z]+$'
                    }
                )
            }
            return $null
        }
    }

    It 'Should construct PsRolConstraintValue with ConstraintTypeId and valid regex' {
        $result = New-RolConstraintValue -ConstraintTypeId 'ct-100' -ConstraintValue '1234'

        $result.GetType().Name | Should -Be 'PsRolConstraintValue'
        $result.ConstraintTypeId | Should -Be 'ct-100'
        $result.ConstraintTypeEntityId | Should -Be 'entity-100'
        $result.ConstraintValue | Should -Be '1234'
        $result.ConstraintValueType | Should -Be 'VALUE'
    }

    It 'Should throw error when ConstraintValue fails regex validation' {
        { New-RolConstraintValue -ConstraintTypeId 'ct-100' -ConstraintValue 'ABCD' } | Should -Throw 'ConstraintValue ''ABCD'' does not match the required format: ^`[0-9`]{4}$'
    }

    It 'Should construct PsRolConstraintValue with ConstraintTypeEntityId' {
        $result = New-RolConstraintValue -ConstraintTypeEntityId 'entity-200' -ConstraintValue 'testvalue'

        $result.ConstraintTypeId | Should -Be 'ct-200'
        $result.ConstraintTypeEntityId | Should -Be 'entity-200'
        $result.ConstraintValue | Should -Be 'testvalue'
    }

    It 'Should throw error when constraint type is not found' {
        { New-RolConstraintValue -ConstraintTypeId 'ct-missing' -ConstraintValue '1234' } | Should -Throw 'Constraint type not found.'
    }
}
