BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe "Test-RolUserRoleAssignment" {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -like '/api/v2/user/user123/assignments*') {
                return @(
                    [PSCustomObject]@{
                        user = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            userId = 'user123'
                            name = 'Test User'
                        }
                        userRole = [PSCustomObject]@{
                            id = 1001
                            name = 'Test Administrator Role'
                            identifier = 'ROLE-ID-001'
                            description = 'Test administrator role description'
                        }
                        assignedThrough = 'DIRECT'
                    },
                    [PSCustomObject]@{
                        user = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            userId = 'user123'
                            name = 'Test User'
                        }
                        userRole = [PSCustomObject]@{
                            id = 1002
                            name = 'Test Standard User Role'
                            identifier = 'id-00000000-0000-0000-0000-000000000002'
                            description = 'Test standard user role description'
                        }
                        assignedThrough = 'DIRECT'
                    },
                    [PSCustomObject]@{
                        user = [PSCustomObject]@{
                            uuid = '00000000-0000-0000-0000-000000000001'
                            userId = 'user123'
                            name = 'Test User'
                        }
                        userRole = [PSCustomObject]@{
                            id = 1003
                            name = 'Test_Custom_App_Role'
                            identifier = 'TEST_CUSTOM_APP_ROLE'
                            description = 'Test custom application role description'
                        }
                        assignedThrough = 'DIRECT'
                    }
                )
            }
            return @()
        }
    }

    It "Should return true when role matches by UserRoleId" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -UserRoleId '1001'
        $result | Should -Be $true
    }

    It "Should return true when role matches by Id alias" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -Id '1001'
        $result | Should -Be $true
    }

    It "Should return true when role matches by Name" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -Name '*Standard User*'
        $result | Should -Be $true
    }

    It "Should return true when role matches by Identifier" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -Identifier 'TEST_CUSTOM_APP_ROLE'
        $result | Should -Be $true
    }

    It "Should return false when role is not present" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -UserRoleId '999999'
        $result | Should -Be $false
    }

    It "Should return false when API returns no assigned roles" {
        $result = Test-RolUserRoleAssignment -UserId 'user404' -UserRoleId '1001'
        $result | Should -Be $false
    }

    It "Should query custom domain when specified" {
        $result = Test-RolUserRoleAssignment -UserId 'user123' -UserRoleId '1001' -Domain 'Skole'
        $result | Should -Be $true
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/user/user123/assignments?domain=Skole' }
    }

    It "Should write error when no UserRoleId, Name, or Identifier is provided" {
        Mock -CommandName Write-Error -ModuleName PsRol -MockWith {}
        $result = Test-RolUserRoleAssignment -UserId 'user123'
        Should -Invoke -CommandName Write-Error -ModuleName PsRol -Times 1 -ParameterFilter { $Message -eq 'Missing parameter for testing user role assignment' }
        $result | Should -BeNullOrEmpty
    }
}
