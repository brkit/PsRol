# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolOrganisation {
    [CmdletBinding()]
    [OutputType([PsRolOrganisation])]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Name
    )

    process {
        $timeoutSeconds = if ($null -ne $Script:OrganisationCacheTimeoutSeconds) { $Script:OrganisationCacheTimeoutSeconds } else { 300 }
        $isExpired = ($null -eq $Script:OrganisationCache) -or 
        ($null -eq $Script:OrganisationCacheTime) -or 
        ((Get-Date) - $Script:OrganisationCacheTime).TotalSeconds -ge $timeoutSeconds

        if ($isExpired) {
            $ApiUrl = '/api/organisation/v3'
            $Response = (Invoke-ApiClient -Uri $ApiUrl -Method GET).orgUnits
            $Script:OrganisationCache = foreach ($item in $Response) {
                [PsRolOrganisation]::new($item)
            }
            $Script:OrganisationCacheTime = Get-Date
        }

        $Organisations = $Script:OrganisationCache

        if ([string]::IsNullOrWhiteSpace($Name)) {
            return $Organisations
        }
        else {
            return $Organisations | Where-Object { $PSItem.Name -match $Name }
        }
    }
}
