BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolManager' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    uuid               = '00000000-0000-0000-0000-000000000001'
                    name               = 'Manager 01'
                    userId             = 'mgr01'
                    managerSubstitutes = @(
                        [PSCustomObject]@{
                            uuid          = '00000000-0000-0000-0000-000000000010'
                            name          = 'Substitute 01'
                            userId        = 'sub01'
                            orgUnitUuid   = '00000000-0000-0000-0000-000000000100'
                            orgUnitName   = 'IT Department'
                            managerUuid   = '00000000-0000-0000-0000-000000000001'
                            managerUserId = 'mgr01'
                        }
                    )
                },
                [PSCustomObject]@{
                    uuid               = '00000000-0000-0000-0000-000000000002'
                    name               = 'Manager 02'
                    userId             = 'mgr02'
                    managerSubstitutes = @(
                        [PSCustomObject]@{
                            uuid          = '00000000-0000-0000-0000-000000000020'
                            name          = 'Substitute 02'
                            userId        = 'sub02'
                            orgUnitUuid   = '00000000-0000-0000-0000-000000000200'
                            orgUnitName   = 'Finance Department'
                            managerUuid   = '00000000-0000-0000-0000-000000000002'
                            managerUserId = 'mgr02'
                        },
                        [PSCustomObject]@{
                            uuid          = '00000000-0000-0000-0000-000000000021'
                            name          = 'Substitute 03'
                            userId        = 'sub03'
                            orgUnitUuid   = '00000000-0000-0000-0000-000000000201'
                            orgUnitName   = 'HR Department'
                            managerUuid   = '00000000-0000-0000-0000-000000000002'
                            managerUserId = 'mgr02'
                        }
                    )
                },
                [PSCustomObject]@{
                    uuid               = '00000000-0000-0000-0000-000000000003'
                    name               = 'Manager 03'
                    userId             = 'mgr03'
                    managerSubstitutes = @()
                }
            )
        }
    }

    It 'Should call the API with correct URI and method' {
        $result = Get-RolManager
        
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/manager' -and $Method -eq 'Get' }
    }

    It 'Should return multiple manager objects with mapped properties' {
        $result = Get-RolManager
        
        $result.Count | Should -Be 3
        $result[0].UserId | Should -Be 'mgr01'
        $result[0].Name | Should -Be 'Manager 01'

        $result[1].UserId | Should -Be 'mgr02'
        $result[1].Name | Should -Be 'Manager 02'

        $result[2].UserId | Should -Be 'mgr03'
        $result[2].Name | Should -Be 'Manager 03'
    }

    It 'Should correctly map substitutes for managers' {
        $result = Get-RolManager
        
        $result[0].Substitutes.Count | Should -Be 1
        $result[0].Substitutes[0].UserId | Should -Be 'sub01'
        $result[0].Substitutes[0].OrgUnitName | Should -Be 'IT Department'

        $result[1].Substitutes.Count | Should -Be 2
        $result[1].Substitutes[0].UserId | Should -Be 'sub02'
        $result[1].Substitutes[1].UserId | Should -Be 'sub03'

        $result[2].Substitutes | Should -BeNullOrEmpty
    }
}
