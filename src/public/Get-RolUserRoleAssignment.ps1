# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolUserRoleAssignment {
    [CmdletBinding()]
    [OutputType([PsRolUserRoleAssignment])]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$UserId,
        [string]$System,
        [string]$Domain
    )

    process {
        $QueryParams = @()
        if (-not [string]::IsNullOrWhiteSpace($System)) {
            $QueryParams += ('system={0}' -f [Uri]::EscapeDataString($System))
        }
        if (-not [string]::IsNullOrWhiteSpace($Domain)) {
            $QueryParams += ('domain={0}' -f [Uri]::EscapeDataString($Domain))
        }

        $ApiUrl = '/api/v2/user/{0}/assignments' -f [Uri]::EscapeDataString($UserId)
        if ($QueryParams.Count -gt 0) {
            $ApiUrl += '?' + ($QueryParams -join '&')
        }

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

        $ReturnObject = foreach ($Assignment in $Response) {
            [PsRolUserRoleAssignment]::new($Assignment)
        }

        return $ReturnObject
    }
}
