BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Get-RolItSystem' {
    BeforeEach {
        & (Get-Module PsRol) {
            $Script:ItSystemCache = $null
            $Script:ItSystemCacheTime = $null
            $Script:CacheTimeoutSeconds = 30
        }
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            return @(
                [PSCustomObject]@{
                    Id = 'system1'
                    name = 'Test System 1'
                    identifier = 'TS1'
                    systemtype = 'AD'
                    paused = $false
                    hidden = $false
                    readonly = $false
                    canEditThroughApi = $true
                    deleted = $false
                    domain = 'Administrativt'
                    email = 'admin@example.org'
                },
                [PSCustomObject]@{
                    Id = 'system2'
                    name = 'Test System 2'
                    identifier = 'TS2'
                    systemtype = 'SAML'
                    paused = $true
                    hidden = $false
                    readonly = $false
                    canEditThroughApi = $false
                    deleted = $false
                    domain = 'Skole'
                    email = 'school@example.org'
                }
            )
        }
    }

    It 'Should return all systems when -All is present' {
        $result = Get-RolItSystem -All
        $result.Count | Should -Be 2
        $result[0].Name | Should -Be 'Test System 1'
    }

    It 'Should return only API maintainable systems by default' {
        $result = Get-RolItSystem
        $result.Count | Should -Be 1
        $result[0].ItSystemId | Should -Be 'system1'
    }

    It 'Should filter by Name' {
        $result = Get-RolItSystem -All -Name 'Test System 2'
        $result.Count | Should -Be 1
        $result[0].ItSystemId | Should -Be 'system2'
    }

    It 'Should filter by Identifier' {
        $result = Get-RolItSystem -All -Identifier 'TS1'
        $result.Count | Should -Be 1
        $result[0].Identifier | Should -Be 'TS1'
    }

    It 'Should cache results on subsequent calls within 30 seconds and not call API again' {
        $result1 = Get-RolItSystem -All
        $result2 = Get-RolItSystem -Name 'Test System 1'
        $result3 = Get-RolItSystem -Identifier 'TS1'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/itsystem' }
        $result2.Count | Should -Be 1
        $result3.Count | Should -Be 1
    }

    It 'Should refresh cache after cache timeout expires' {
        $result1 = Get-RolItSystem -All

        # Fast forward time past 30 seconds
        & (Get-Module PsRol) { $Script:ItSystemCacheTime = (Get-Date).AddSeconds(-31) }

        $result2 = Get-RolItSystem -All

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2 -ParameterFilter { $Uri -eq '/api/v2/itsystem' }
    }

    It 'Should respect module author configured CacheTimeoutSeconds' {
        & (Get-Module PsRol) { $Script:CacheTimeoutSeconds = 10 }

        $result1 = Get-RolItSystem -All

        # Fast forward time past 10 seconds
        & (Get-Module PsRol) { $Script:ItSystemCacheTime = (Get-Date).AddSeconds(-11) }

        $result2 = Get-RolItSystem -All

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 2 -ParameterFilter { $Uri -eq '/api/v2/itsystem' }
    }

    It 'Should call specific system endpoint and not use cache when itSystemId is provided' {
        # Prime list cache first
        Get-RolItSystem -All | Out-Null

        # Call with specific ID
        Get-RolItSystem -itSystemId 'system1' | Out-Null
        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter { $Uri -eq '/api/v2/itsystem/system1' }
    }
}
