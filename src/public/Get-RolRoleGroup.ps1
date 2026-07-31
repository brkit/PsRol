# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolRoleGroup {
    [CmdletBinding()]
    [OutputType([PsRolRoleGroup])]
    param (
        
    )
    
    $ApiUrl = '/api/v2/rolegroup'

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'Get' -Body ''

    $RoleGroups = $Response

    $ReturnObject = foreach ($RoleGroup in $RoleGroups) {
        [PsRolRoleGroup]::new($RoleGroup)
    }
    
    Set-DefaultDisplayPropertySet -InputObject $ReturnObject -Properties 'Name', 'Description', 'UserRoles'

    return $ReturnObject

}
