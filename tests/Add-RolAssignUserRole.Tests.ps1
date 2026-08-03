BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Add-RolAssignUserRole' {
    BeforeEach {
        $WhatIfPreference = $false
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {}
        Mock -CommandName Write-Warning -ModuleName PsRol -MockWith {}
    }

    It 'Should call API with correct URL and default parameters' {
        $startDate = Get-Date
        $expectedDateStr = $startDate.ToString('yyyy-MM-dd')
        
        Add-RolAssignUserRole -UserId 'user01' -UserRoleId 500 -StartDate $startDate

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/user01/assign/userrole/500' -and
            $Method -eq 'PUT' -and
            $Body -match '"domain"\s*:\s*"Administrativt"' -and
            $Body -match '"onlyIfNotAssigned"\s*:\s*true' -and
            $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedDateStr)
        }
    }

    It 'Should include stopDate and handle AllowExtraAssignments' {
        $startDate = Get-Date
        $stopDate = $startDate.AddDays(30)
        $expectedStart = $startDate.ToString('yyyy-MM-dd')
        $expectedStop = $stopDate.ToString('yyyy-MM-dd')

        Add-RolAssignUserRole -UserId 'user02' -UserRoleId 600 -StartDate $startDate -StopDate $stopDate -Domain 'Skole' -AllowExtraAssignments

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/user02/assign/userrole/600' -and
            $Method -eq 'PUT' -and
            $Body -match '"domain"\s*:\s*"Skole"' -and
            $Body -match '"onlyIfNotAssigned"\s*:\s*false' -and
            $Body -match ('"startDate"\s*:\s*"{0}"' -f $expectedStart) -and
            $Body -match ('"stopDate"\s*:\s*"{0}"' -f $expectedStop)
        }
    }

    It 'Should respect WhatIf and not invoke API when WhatIf is present' {
        Add-RolAssignUserRole -UserId 'user01' -UserRoleId 100 -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
    }

    It 'Should accept Microsoft.ActiveDirectory.Management.ADUser via pipeline' {
        $adUser = [PSCustomObject]@{
            SamAccountName = 'aduser01'
            objectClass    = 'user'
        }
        $adUser.PSTypeNames.Insert(0, 'Microsoft.ActiveDirectory.Management.ADUser')

        $adUser | Add-RolAssignUserRole -UserRoleId 500

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/aduser01/assign/userrole/500'
        }
    }

    It 'Should accept Microsoft.ActiveDirectory.Management.ADPrincipal via pipeline when objectClass is user' {
        $adPrincipal = [PSCustomObject]@{
            SamAccountName = 'adprincipal01'
            objectClass    = 'user'
        }
        $adPrincipal.PSTypeNames.Insert(0, 'Microsoft.ActiveDirectory.Management.ADPrincipal')

        $adPrincipal | Add-RolAssignUserRole -UserRoleId 500

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/user/adprincipal01/assign/userrole/500'
        }
    }

    It 'Should issue warning and skip when Microsoft.ActiveDirectory.Management.ADPrincipal objectClass is not user' {
        $adGroup = [PSCustomObject]@{
            SamAccountName = 'adgroup01'
            objectClass    = 'group'
        }
        $adGroup.PSTypeNames.Insert(0, 'Microsoft.ActiveDirectory.Management.ADPrincipal')

        $adGroup | Add-RolAssignUserRole -UserRoleId 500

        Should -Invoke -CommandName Write-Warning -ModuleName PsRol -Times 1 -ParameterFilter {
            $Message -match 'objectClass must be ''user'''
        }
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
    }

    It 'Should resolve UserRoleId by Name when a single user role is found' {
        InModuleScope 'PsRol' {
            Mock -CommandName Get-RolUserRole -ModuleName PsRol -MockWith {
                return @(
                    [PsRolUserRole]@{
                        UserRoleId  = 700
                        Name        = 'Unique Admin Role'
                        Description = 'Admin role'
                    }
                )
            }
                
                
            Add-RolAssignUserRole -UserId 'user01' -Name 'Unique Admin Role'
                
            Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq '/api/v2/user/user01/assign/userrole/700'
            }
        }
    }

    It 'Should throw error prompting user to specify Id when multiple roles have the same Name' {
        InModuleScope 'PsRol' {
            Mock -CommandName Get-RolUserRole -ModuleName PsRol -MockWith {
                return @(
                    [PsRolUserRole]@{
                        UserRoleId  = 701
                        Name        = 'Duplicate Role'
                        Description = 'First duplicate'
                    },
                    [PsRolUserRole]@{
                        UserRoleId  = 702
                        Name        = 'Duplicate Role'
                        Description = 'Second duplicate'
                    }
                )
            }

            { Add-RolAssignUserRole -UserId 'user01' -Name 'Duplicate Role' } | Should -Throw '*Multiple user roles found with Name ''Duplicate Role''. Please specify the Id instead.*'
        }
    }

    It 'Should throw error when UserRole is not found by Name' {
        Mock -CommandName Get-RolUserRole -ModuleName PsRol -MockWith {
            return @()
        }

        { Add-RolAssignUserRole -UserId 'user01' -Name 'NonExistent' } | Should -Throw '*UserRole with Name ''NonExistent'' not found.*'
    }
}
