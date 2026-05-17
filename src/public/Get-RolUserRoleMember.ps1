# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolUserRoleMember {
    [CmdletBinding()]
    param (
        [string]$UserRoleId
    )
    
    $ApiUrl = '/api/v2/userrole/{0}/users' -f $UserRoleId

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'Get' -Body ''

    $ReturnObject = foreach ($UserRoleAssignment in $Response) {
        [PsRolUserRoleMember]::new($UserRoleAssignment)
    }

    return $ReturnObject
}