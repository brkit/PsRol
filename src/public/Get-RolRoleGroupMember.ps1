# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolRoleGroupMember {
    [CmdletBinding()]
    [OutputType([PsRolUser])]
    param (
        [string]$RoleGroupId
    )
    
    $ApiUrl = '/api/v2/rolegroup/{0}/users' -f $RoleGroupId

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

    $ReturnObject = foreach ($item in $Response) {
        [PsRolUser]::new($item)
    }

    Set-DefaultDisplayPropertySet -InputObject $ReturnObject -Properties 'UserId', 'ExtUuid', 'Name'

    return $ReturnObject
}