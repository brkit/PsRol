# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolItSystemRole {
    [CmdletBinding()]
    [OutputType([PsRolSystemRole])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ItSystemId
    )
    process {
        $ApiUrlPart = '/api/v2/itsystem/{0}/systemroles' -f $ItSystemId

        $Response = Invoke-ApiClient -Uri $ApiUrlPart -Method 'GET'
        
        $Response.PSForEach({ [PsRolSystemRole]::new($PSItem) })
    }
}