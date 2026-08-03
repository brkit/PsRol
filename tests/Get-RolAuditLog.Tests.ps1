BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolAuditLog' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method)
            if ($Uri -eq '/api/v2/auditlog/head') {
                return [PSCustomObject]@{ head = 100 }
            }
            if ($Uri -like '/api/v2/auditlog/read*') {
                return @(
                    [PSCustomObject]@{
                        id = 60
                        timestamp = '2026-07-30T10:00:00Z'
                        ipAddress = '127.0.0.1'
                        username = 'testuser'
                        entityType = 'USERROLE'
                        entityId = '123'
                        entityName = 'Test Role'
                        eventType = 'CREATE'
                        description = 'Created role'
                    }
                )
            }
        }
    }

    It 'Should calculate offset correctly using -Latest' {
        $result = Get-RolAuditLog -Latest 5
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/auditlog/head' }
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/auditlog/read?offset=80&size=20' }
        $result.Count | Should -Be 1
        $result[0].Username | Should -Be 'testuser'
    }

    It 'Should use default offset and size when -Latest is omitted' {
        Get-RolAuditLog | Out-Null
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/auditlog/read?offset=0&size=250' }
    }
}
