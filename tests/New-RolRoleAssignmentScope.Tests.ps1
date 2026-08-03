BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}
Describe 'New-RolRoleAssignmentScope' {
    It 'Should construct TITLE scope' {
        InModuleScope 'PsRol' {
            $title = [PsRolTitle]@{ name = 'Teacher'; uuid = '00000000-0000-0000-0000-000000000001' }
            $scope = New-RolRoleAssignmentScope -Type TITLE -Title $title
            $scope.type | Should -Be 'TITLE'
            $scope.titles.Count | Should -Be 1
        }
    }
        
    It 'Should construct MANAGER scope' {
        $scope = New-RolRoleAssignmentScope -Type MANAGER -Manager -Substitute
        $scope.type | Should -Be 'MANAGER'
        $scope.manager | Should -Be $true
        $scope.substitute | Should -Be $true
    }
        
    It 'Should construct FUNCTION scope' {
        $scope = New-RolRoleAssignmentScope -Type FUNCTION -Functions 'Tillidsmand', 'Leder'
        $scope.type | Should -Be 'FUNCTION'
        $scope.functions.Count | Should -Be 2
    }
        
    It 'Should construct EXCLUDED_TITLE scope' {
        InModuleScope 'PsRol' {
            $title = [PsRolTitle]@{ name = 'Consultant'; uuid = '00000000-0000-0000-0000-000000000002' }
            $scope = New-RolRoleAssignmentScope -Type EXCLUDED_TITLE -ExcludedTitles $title
            $scope.type | Should -Be 'EXCLUDED_TITLE'
            $scope.excludedTitles.Count | Should -Be 1
        }
    }
    
    It 'Should construct EXCEPTED_USER scope' {
        InModuleScope 'PsRol' {
            $user = [PsRolUser]@{ uuid = '00000000-0000-0000-0000-000000000003'; userId = 'testuser'; extUuid = '00000000-0000-0000-0000-000000000004'; name = 'Test Tester' }
            $scope = New-RolRoleAssignmentScope -Type EXCEPTED_USER -ExceptedUsers $user
            $scope.type | Should -Be 'EXCEPTED_USER'
            $scope.exceptedUsers.Count | Should -Be 1
        }
    }
}