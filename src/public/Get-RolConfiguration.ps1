# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolConfiguration {
    $ConfigPath = (Join-Path '~' '.PsRolConfig.json')
    if(-not ($Script:Configuration -is [hashtable])) {
        If(Test-Path -LiteralPath $ConfigPath) {
            $Script:Configuration = Get-Content -Path $ConfigPath | ConvertFrom-Json -AsHashtable
        } else {
            $Script:Configuration = @{}
        }
    }
    
    return $Script:Configuration
}