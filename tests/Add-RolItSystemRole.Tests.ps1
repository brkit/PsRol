BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Add-RolItSystemRole' {
    It 'Should throw error if ItSystem does not exist' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { throw 'NotFound' }
        }

        { Add-RolItSystemRole -ItSystemId 999 -Name 'Role 1' -Identifier 'ID1' } | Should -Throw 'It System with ItSystemId 999 not found.'
    }

    It 'Should create system role and return PsRolSystemRole object' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method, $Body)
            if ($Method -eq 'GET' -and $Uri -eq '/api/v2/itsystem/100') {
                return [PSCustomObject]@{ id = '100'; name = 'System 100' }
            }
            if ($Method -eq 'POST' -and $Uri -eq '/api/v2/itsystem/100/systemroles?AdGroupType=NONE&universal=false') {
                return [PSCustomObject]@{
                    id          = 1234
                    name        = 'Role 1'
                    identifier  = 'ID1'
                    description = 'Test role description'
                    weight      = 2
                }
            }
        }

        $result = Add-RolItSystemRole -ItSystemId 100 -Name 'Role 1' -Identifier 'ID1' -Description 'Test role description' -Weight 2
        
        $result | Should -Not -BeNullOrEmpty
        $result.GetType().Name | Should -Be 'PsRolSystemRole'
        $result.Name | Should -Be 'Role 1'
        $result.SystemRoleIdentifier | Should -Be 'ID1'
    }

    It 'Should accept pipeline input by property name for ItSystemId' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { return [PSCustomObject]@{ id = 200 } }
            if ($Method -eq 'POST') {
                return [PSCustomObject]@{ id = 555; name = 'Role 2'; identifier = 'ID2' }
            }
        }

        $inputObj = [PSCustomObject]@{ ItSystemId = 200 }
        $result = $inputObj | Add-RolItSystemRole -Name 'Role 2' -Identifier 'ID2'
        $result.SystemRoleId | Should -Be 555
    }

    It 'Should respect WhatIf' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { return [PSCustomObject]@{ id = 100 } }
        }

        Add-RolItSystemRole -ItSystemId 100 -Name 'Role 1' -Identifier 'ID1' -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Method -eq 'GET' }
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0 -ParameterFilter { $Method -eq 'POST' }
    }
}
