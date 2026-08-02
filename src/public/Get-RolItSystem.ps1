# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolItSystem {
    [CmdletBinding()]
    [OutputType([PsRolItSystem])]
    param (
        [string]$ItSystemId,
        [string]$Name,
        [string]$Identifier,
        [switch]$All
    )

    if (-not [string]::IsNullOrEmpty($ItSystemId)) {
        $ApiUrlPart = '/api/v2/itsystem/' + $ItSystemId
        $Response = Invoke-ApiClient -Uri $ApiUrlPart -Method 'GET'
    }
    else {
        $timeoutSeconds = if ($null -ne $Script:CacheTimeoutSeconds) { $Script:CacheTimeoutSeconds } else { 30 }
        $isExpired = ($null -eq $Script:ItSystemCache) -or 
        ($null -eq $Script:ItSystemCacheTime) -or 
        ((Get-Date) - $Script:ItSystemCacheTime).TotalSeconds -ge $timeoutSeconds

        if ($isExpired) {
            $ApiUrlPart = '/api/v2/itsystem'
            $Script:ItSystemCache = Invoke-ApiClient -Uri $ApiUrlPart -Method 'GET'
            $Script:ItSystemCacheTime = Get-Date
        }
        $Response = $Script:ItSystemCache
    }

    if ($All.IsPresent) { 
        $itSystems = $Response
    }
    else {
        $itSystems = $Response.PSWhere({ $PSItem.canEditThroughApi })
    }

    if (-not [string]::IsNullOrEmpty($Name)) {
        $itSystems = $itSystems.PSWhere({ $PSItem.Name -match $Name })
    }

    if (-not [string]::IsNullOrEmpty($Identifier)) {
        $itSystems = $itSystems.PSWhere({ $PSItem.identifier -match $Identifier })
    }

    $ReturnObject = foreach ($itSystem in $itSystems) { 
        [PsRolItSystem]::new($itSystem)
    }

    Set-DefaultDisplayPropertySet -InputObject $ReturnObject -Properties 'ItSystemId', 'Name', 'Identifier', 'SystemType'

    return $ReturnObject
}