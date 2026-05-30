# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Remove-RolUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [String]$UserRoleId
    )
    
    process {
        $ApiUrl = '/api/v2/userrole/{0}' -f $UserRoleId

        Invoke-ApiClient -Uri $ApiUrl -Method 'DELETE'
    }

}