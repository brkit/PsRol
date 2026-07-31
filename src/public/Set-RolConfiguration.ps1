# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Set-RolConfiguration {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory)]
        [string]$BaseUrl,
        [Parameter(Mandatory)]
        [string]$ApiKey,
        [switch]$AsDotFile,
        [switch]$ApiKeyInDotFile
    )
    begin {
        if (-not ($Script:Configuration -is [hashtable])) {
            $Script:Configuration = @{}
        }
    }
    process {
        if ($BaseUrl) {
            # validate URL
            $URL = $BaseUrl -as [System.URI]
            if ($null -eq $URL.AbsoluteURI -or $URL.Scheme -ne 'https') {
                throw 'Invalid URL: ''{0}''. Only HTTPS is supported' -f $BaseUrl
            }
        }

        $Target = if ($AsDotFile) { 
            (Join-Path '~' '.PsRolConfig.json') 
        }
        else {
            'Session Configuration'
        }

        if ($PSCmdlet.ShouldProcess($Target, 'Set BaseUrl and ApiKey')) {
            $Script:Configuration['BaseUrl'] = $BaseUrl
            $Script:Configuration['ApiKey'] = $ApiKey

            if ($AsDotFile.IsPresent) {
                $DotConfig = $Script:Configuration.Clone()
                if ($ApiKeyInDotFile.IsPresent) {
                    Write-Warning 'ApiKey is stored in plaintext without protection. You have been warned.'
                }
                else {
                    $DotConfig.Remove('ApiKey')
                }
                $DotConfig | ConvertTo-Json | Out-File (Join-Path '~' '.PsRolConfig.json')
            }
        }
    }
}