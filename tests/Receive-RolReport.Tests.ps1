BeforeAll {
    $ProjectInfo = Get-MTProjectInfo
    Import-Module -Name $ProjectInfo.OutputModuleDir -ErrorAction Stop
}

AfterAll {
    Remove-Module PsRol
}

Describe 'Receive-RolReport' {
    BeforeEach {
        Mock -CommandName Invoke-ApiClient -ModuleName PsRol -MockWith {
            param($Uri, $Method, $Body, $OutFile)
            if ($OutFile) { return $OutFile }
            return [PSCustomObject]@{ status = 'ok' }
        }
    }

    It 'Should POST to /api/v2/report with formatted date' {
        $reportDate = [datetime]'2026-07-31'

        Receive-RolReport -ReportDate $reportDate

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/report' -and
            $Method -eq 'POST' -and
            $Body -match '"date"\s*:\s*"2026-07-31"' -and
            $Body -match '"showUserRoles"\s*:\s*true'
        }
    }

    It 'Should pass OutFile parameter to Invoke-ApiClient' {
        $reportDate = [datetime]'2026-07-31'
        $outFile = 'C:\temp\report.xlsx'

        $result = Receive-RolReport -ReportDate $reportDate -OutFile $outFile

        Should -Invoke -CommandName Invoke-ApiClient -ModuleName PsRol -Times 1 -ParameterFilter {
            $Uri -eq '/api/v2/report' -and
            $OutFile -eq 'C:\temp\report.xlsx'
        }
        $result | Should -Be 'C:\temp\report.xlsx'
    }
}
