# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Set-RolConfiguration {
    [CmdletBinding()]
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
        
        
        If ($BaseUrl) {
            # validate URL
            $URL = $BaseUrl -as [System.URI]
            if (($null -eq $URL.AbsoluteURI -and $URL.Scheme -notmatch '^https$')) {
                throw 'Invalid URL: ''{0}''. Only HTTPS is supported' -f $BaseUrl
            }
            $Script:Configuration["BaseUrl"] = $BaseUrl
        }

        If ($ApiKey) {
            $Script:Configuration['ApiKey'] = $ApiKey
        }
    }
    
    end {
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