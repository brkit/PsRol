BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolUserRole' {
    BeforeEach {
        & (Get-Module PsRol) {
            $Script:UserRoleCache = $null
            $Script:UserRoleCacheTime = $null
            $Script:CacheTimeoutSeconds = 30
        }
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    id          = 101
                    name        = 'Administrativ Superuser'
                    description = 'Full access role'
                },
                [PSCustomObject]@{
                    id          = 102
                    name        = 'Skole Lærer Role'
                    description = 'Teacher role'
                }
            )
        }
    }

    It 'Should call API and return strongly typed PsRolUserRole objects when -Name is omitted' {
        InModuleScope 'PsRol' {
            $result = Get-RolUserRole
            
            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq '/api/v2/userrole' -and $Method -eq 'GET'
            }
            $result.Count | Should -Be 2
            $result[0].GetType().Name | Should -Be 'PsRolUserRole'
            $result[0].UserRoleId | Should -Be 101
            $result[0].Id | Should -Be 101
            $result[0].Name | Should -Be 'Administrativ Superuser'
            $result[0].Description | Should -Be 'Full access role'
        }
    }

    It 'Should filter user roles by Name wildcard using cached results within 30 seconds' {
        $result1 = Get-RolUserRole
        $result2 = Get-RolUserRole -Name '*Skole*'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole' -and $Method -eq 'GET'
        }
        $result2.Count | Should -Be 1
        $result2[0].UserRoleId | Should -Be 102
        $result2[0].Name | Should -Be 'Skole Lærer Role'
    }

    It 'Should refresh cache after cache timeout expires' {
        $result1 = Get-RolUserRole

        # Simulate cache expiration by setting cache timestamp 31 seconds in the past
        & (Get-Module PsRol) { $Script:UserRoleCacheTime = (Get-Date).AddSeconds(-31) }

        $result2 = Get-RolUserRole

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2 -ParameterFilter {
            $Uri -eq '/api/v2/userrole' -and $Method -eq 'GET'
        }
    }

    It 'Should respect module author configured CacheTimeoutSeconds' {
        # Configure cache duration to 5 seconds
        & (Get-Module PsRol) { $Script:CacheTimeoutSeconds = 5 }

        $result1 = Get-RolUserRole

        # Fast forward cache timestamp by 6 seconds
        & (Get-Module PsRol) { $Script:UserRoleCacheTime = (Get-Date).AddSeconds(-6) }

        $result2 = Get-RolUserRole

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2 -ParameterFilter {
            $Uri -eq '/api/v2/userrole' -and $Method -eq 'GET'
        }
    }

    It 'Should call API directly and not use cache when UserRoleId is specified' {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return [PSCustomObject]@{
                id          = 101
                name        = 'Administrativ Superuser'
                description = 'Full access role'
            }
        }

        # Prime the cache first with general list call
        Get-RolUserRole | Out-Null

        # Call with UserRoleId
        $result = Get-RolUserRole -UserRoleId 101

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/userrole/101' -and $Method -eq 'GET'
        }
        $result.UserRoleId | Should -Be 101
    }
}
