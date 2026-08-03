BeforeDiscovery {
    $files = Get-ChildItem -Path .\src -Filter '*.ps1' -Recurse -Exclude '*.tests.ps1' # Exclude testing tests, we don't allow fourth wall breaks here :^)
}
BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop

    # Load class definitions into session state in dependency order
    $classFiles = Get-ChildItem -Path .\src\classes -Filter '*.ps1'
    $remaining = [System.Collections.Generic.List[System.IO.FileInfo]]::new([System.IO.FileInfo[]]$classFiles)
    while ($remaining.Count -gt 0) {
        $loadedAny = $false
        for ($i = $remaining.Count - 1; $i -ge 0; $i--) {
            try {
                . $remaining[$i].FullName
                $remaining.RemoveAt($i)
                $loadedAny = $true
            }
            catch {
                # Dependent type not yet loaded, retry on next pass
            }
        }
        if (-not $loadedAny) { break }
    }

    $ScriptAnalyzerSettings = @{
        IncludeDefaultRules = $true
        Severity            = @('Warning', 'Error')
        ExcludeRules        = @('PSReviewUnusedParameter')
    }

    Import-Module 'PSScriptAnalyzer' -ErrorAction SilentlyContinue
    $scriptAnalyzerCmd = Get-Command -Name 'Invoke-ScriptAnalyzer' -ErrorAction SilentlyContinue
}
Describe 'File: <_.name>' -ForEach $files {
    Context 'Code Quality Check' {
        It 'is valid PowerShell Code' {
            $psFile = Get-Content -Path $PSItem -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
            $syntaxErrors = $errors | Where-Object { $_.Type -ne 'TypeNotFound' -and $_.Message -notmatch 'TypeNotFound' }
            $syntaxErrors.Count | Should -Be 0
        }
        It 'passess ScriptAnalyzer' {
            if (-not $scriptAnalyzerCmd) {
                Set-ItResult -Skipped -Because 'PSScriptAnalyzer module is not installed.'
                return
            }
            $saResults = Invoke-ScriptAnalyzer -Path $PSItem -Settings $ScriptAnalyzerSettings | Where-Object { $_.Message -notmatch 'TypeNotFound' }
            $saResults | Should -BeNullOrEmpty -Because $($saResults.Message -join ';')
        }         
    }
}