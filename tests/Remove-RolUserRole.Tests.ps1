BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Remove-RolUserRole' {
    It 'Should throw error if UserRole does not exist' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { return $null }
        }

        { Remove-RolUserRole -UserRoleId '999' } | Should -Throw 'UserRole ''999'' not found.'
    }

    It 'Should fetch UserRole and DELETE it when confirmed' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET' -and $Uri -eq '/api/v2/userrole/100') {
                return [PSCustomObject]@{ id = 100; name = 'Role To Delete' }
            }
            if ($Method -eq 'DELETE' -and $Uri -eq '/api/v2/userrole/100') {
                return $true
            }
        }

        Remove-RolUserRole -UserRoleId '100' -Confirm:$false

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole/100' -and $Method -eq 'GET'
        }
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole/100' -and $Method -eq 'DELETE'
        }
    }

    It 'Should accept pipeline input by property name for UserRoleId' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { return [PSCustomObject]@{ id = 200; name = 'Pipeline Role' } }
            if ($Method -eq 'DELETE') { return $true }
        }

        $inputObj = [PSCustomObject]@{ UserRoleId = '200' }
        $inputObj | Remove-RolUserRole -Confirm:$false

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole/200' -and $Method -eq 'DELETE'
        }
    }

    It 'Should respect WhatIf' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Method -eq 'GET') { return [PSCustomObject]@{ id = 300; name = 'WhatIf Role' } }
        }

        Remove-RolUserRole -UserRoleId '300' -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Method -eq 'GET' }
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0 -ParameterFilter { $Method -eq 'DELETE' }
    }
}
