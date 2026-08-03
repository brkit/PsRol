BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'New-RolItSystem' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method, $Body)
            return [PSCustomObject]@{
                id = 'sys-new-100'
                name = 'New System'
            }
        }
        Mock -CommandName Write-Warning -ModuleName PsRol -MockWith {}
    }

    It 'Should send correct body to /api/v2/itsystem' {
        $result = New-RolItSystem -Name 'New Manual System' -SystemIdentifier 'MN01' -ItSystemType MANUAL -Hidden -Domain 'Skole'

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/itsystem' -and
            $Method -eq 'POST' -and
            $Body -match '"name"\s*:\s*"New Manual System"' -and
            $Body -match '"identifier"\s*:\s*"MN01"' -and
            $Body -match '"hidden"\s*:\s*true' -and
            $Body -match '"domain"\s*:\s*"Skole"'
        }
        $result.id | Should -Be 'sys-new-100'
    }

    It 'Should issue warning when creating unpaused AD system' {
        New-RolItSystem -Name 'AD System' -SystemIdentifier 'AD01' -ItSystemType AD

        Should -Invoke -CommandName Write-Warning -ModuleName PsRol -Times 1 -ParameterFilter {
            $Message -match 'Systems of type ''AD'' are paused on creation'
        }
    }

    It 'Should not issue warning when AD system is created with -Paused' {
        New-RolItSystem -Name 'AD System' -SystemIdentifier 'AD01' -ItSystemType AD -Paused

        Should -Invoke -CommandName Write-Warning -ModuleName PsRol -Times 0
    }

    It 'Should respect WhatIf' {
        New-RolItSystem -Name 'Test System' -SystemIdentifier 'TS01' -ItSystemType MANUAL -WhatIf

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 0
    }
}
