# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolRoleGroupMember {
    [CmdletBinding()]
    param (
        [string]$RoleGroupId
    )
    
    $ApiUrl = '/api/v2/rolegroup/{0}/users' -f $RoleGroupId

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'Get' -Body ''

    $ReturnObject = $Response

    return $ReturnObject

}