# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolOrganisation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [string]$Name
    )

    process {
        $ApiUrl = '/api/organisation/v3'
        $Response = (Invoke-ApiClient -Uri $ApiUrl -Method GET).orgUnits
        
        if ([string]::IsNullOrWhiteSpace($Name)) {
            return $Response | ForEach-Object { [PsRolOrganisation]::new($PSItem) }
        }
        else {
            return $Response | Where-Object { $PSItem.Name -match $Name } | ForEach-Object { [PsRolOrganisation]::new($PSItem) }
        }
    }
}
