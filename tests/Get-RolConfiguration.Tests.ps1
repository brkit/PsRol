BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
    Mock -CommandName Join-Path -ModuleName 'PsRol' -MockWith { return $tempFile } -ParameterFilter { $Path -eq '~' -and $ChildPath -eq '.PsRolConfig.json' }
    $tempFile = [System.IO.Path]::GetTempFileName()
    $Script:Configuration = $null
}

AfterAll {
    if (Test-Path $tempFile) {
        Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    }
    Remove-Module PsRol
}

Describe 'Get-RolConfiguration' {
        
    It 'Should return empty hashtable if config file does not exist' {
        $result = Get-RolConfiguration
        $result
        $result.Count | Should -Be 0
        $result | Should -BeNullOrEmpty
    }

    It 'Should return parsed JSON as hashtable if config file exists' {
        '{"BaseUrl": "https://api.test", "ApiKey": "secret"}' | Set-Content -Path $tempFile
            
        $result = Get-RolConfiguration
        $result.BaseUrl | Should -Be 'https://api.test'
        $result.ApiKey | Should -Be 'secret'
    }
}
