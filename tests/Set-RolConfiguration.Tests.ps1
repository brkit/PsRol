BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Set-RolConfiguration' {
    BeforeEach {
        InModuleScope 'PsRol' {
            $Script:Configuration = @{}
        }
    }

    It 'Should set BaseUrl and ApiKey in Script:Configuration' {
        Set-RolConfiguration -BaseUrl 'https://api.example.com' -ApiKey 'secret123'
        (Get-RolConfiguration).BaseUrl | Should -Be 'https://api.example.com'
        (Get-RolConfiguration).ApiKey | Should -Be 'secret123'
    }

    It 'Should throw an error for an invalid BaseUrl' {
        { Set-RolConfiguration -BaseUrl 'not-a-url' -ApiKey 'secret123' } | Should -Throw 'Invalid URL: ''not-a-url''. Only HTTPS is supported'
    }

    It 'Should throw an error when using http' {
        { Set-RolConfiguration -BaseUrl 'http://api.example.org' -ApiKey 'secret123' } | Should -Throw 'Invalid URL: ''http://api.example.org''. Only HTTPS is supported'
    }

    It 'Should not modify configuration when -WhatIf is specified' {
        Set-RolConfiguration -BaseUrl 'https://api.example.com' -ApiKey 'secret123' -WhatIf
        (Get-RolConfiguration).BaseUrl | Should -BeNullOrEmpty
        (Get-RolConfiguration).ApiKey | Should -BeNullOrEmpty
    }

    Context 'With -AsDotFile' {
        BeforeAll {
            $tempFile = [System.IO.Path]::GetTempFileName()
        }

        BeforeEach {
            Mock -CommandName Join-Path -ModuleName 'PsRol' -MockWith { return $tempFile } -ParameterFilter { $Path -eq '~' -and $ChildPath -eq '.PsRolConfig.json' }
            Mock -CommandName Write-Warning -ModuleName 'PsRol' -MockWith {}
        }

        AfterAll {
            if (Test-Path $tempFile) {
                Remove-Item $tempFile -Force
            }
        }

        It 'Should save configuration without ApiKey if -ApiKeyInDotFile is not present' {
            Set-RolConfiguration -BaseUrl 'https://api.example.com' -ApiKey 'secret123' -AsDotFile
            
            $savedConfig = Get-Content $tempFile -Raw | ConvertFrom-Json
            $savedConfig.BaseUrl | Should -Be 'https://api.example.com'
            $savedConfig.ApiKey | Should -BeNullOrEmpty
        }

        It 'Should save configuration with ApiKey and issue a warning if -ApiKeyInDotFile is present' {
            Mock -CommandName Write-Warning -MockWith {}
            Set-RolConfiguration -BaseUrl 'https://api.example.com' -ApiKey 'secret123' -AsDotFile -ApiKeyInDotFile
            
            Should -Invoke -CommandName Write-Warning -ModuleName 'PsRol' -Times 1 -ParameterFilter { $Message -match 'ApiKey is stored in plaintext' }
            
            $savedConfig = Get-Content $tempFile -Raw | ConvertFrom-Json
            $savedConfig.BaseUrl | Should -Be 'https://api.example.com'
            $savedConfig.ApiKey | Should -Be 'secret123'
        }
    }
}
