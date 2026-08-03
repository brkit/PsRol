BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Invoke-ApiClient' {
    BeforeEach {
        InModuleScope 'PsRol' {
            $Script:Configuration = @{
                BaseUrl = 'https://api.example.com'
                ApiKey  = 'test-key-123'
            }
        }
    }

    It 'Should throw error if module is not configured' {
        InModuleScope 'PsRol' {
            $Script:Configuration = @{}
            Mock -CommandName Get-RolConfiguration -ModuleName PsRol -MockWith { return @{} }
            { Invoke-ApiClient -Uri '/api/v2/test' -Method 'GET' } | Should -Throw 'PsRol is not configured. Run Set-RolConfiguration first.'
        }
    }

    It 'Should invoke web request with BaseUrl, ApiKey, and parse JSON response' {
        InModuleScope 'PsRol' {
            Mock -CommandName Invoke-WebRequest -ModuleName PsRol -MockWith {
                return [PSCustomObject]@{
                    Headers = @{ 'Content-Type' = 'application/json; charset=utf-8' }
                    Content = '{"status":"success","data":[1,2,3]}'
                }
            }

            $result = Invoke-ApiClient -Uri '/api/v2/test' -Method 'GET'

            Should -Invoke -CommandName Invoke-WebRequest -ModuleName PsRol -Times 1 -ParameterFilter {
                $Uri -eq 'https://api.example.com/api/v2/test' -and
                $Method -eq 'GET' -and
                $Headers['ApiKey'] -eq 'test-key-123'
            }
            $result.status | Should -Be 'success'
            $result.data.Count | Should -Be 3
        }
    }

    It 'Should return null on 404 Http Response Exception' {
        InModuleScope 'PsRol' {
            Mock -CommandName Invoke-WebRequest -ModuleName PsRol -MockWith {
                $ex = [Microsoft.PowerShell.Commands.HttpResponseException]::new('Not Found', [System.Net.Http.HttpResponseMessage]::new([System.Net.HttpStatusCode]::NotFound))
                throw $ex
            }

            $result = Invoke-ApiClient -Uri '/api/v2/missing' -Method 'GET'
            $result | Should -BeNullOrEmpty
        }
    }

    It 'Should handle binary Content-Type with OutFile' {
        InModuleScope 'PsRol' {
            $tempOut = [System.IO.Path]::GetTempFileName()
            try {
                Mock -CommandName Invoke-WebRequest -ModuleName PsRol -MockWith {
                    $bytes = [System.Text.Encoding]::UTF8.GetBytes('dummy excel data')
                    $stream = [System.IO.MemoryStream]::new($bytes)
                    return [PSCustomObject]@{
                        Headers          = @{ 'Content-Type' = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }
                        RawContentStream = $stream
                    }
                }

                $res = Invoke-ApiClient -Uri '/api/v2/report' -Method 'GET' -OutFile $tempOut
                $res | Should -Be $tempOut
                (Get-Content $tempOut -Raw) | Should -Be 'dummy excel data'
            }
            finally {
                if (Test-Path $tempOut) { Remove-Item $tempOut -Force }
            }
        }
    }

    It 'Should call Write-Error for binary Content-Type when OutFile is missing' {
        InModuleScope 'PsRol' {
            Mock -CommandName Invoke-WebRequest -ModuleName PsRol -MockWith {
                return [PSCustomObject]@{
                    Headers = @{ 'Content-Type' = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }
                }
            }
            Mock -CommandName Write-Error -ModuleName PsRol -MockWith {}

            Invoke-ApiClient -Uri '/api/v2/report' -Method 'GET'

            Should -Invoke -CommandName Write-Error -ModuleName PsRol -Times 1 -ParameterFilter {
                $Message -match 'Received binary data, this must be saved using the OutFile parameter'
            }
        }
    }
}
