# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolUserRole {
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param (
        [AllowEmptyString()]
        [string]$Name
    )
    
    process {
        $ApiUrl = '/api/v2/userrole'

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
        $UserRoles = foreach ($UserRoleInResponse in $Response) {
            [PSCustomObject]@{
                UserRoleId  = $UserRoleInResponse.id
                Name        = $UserRoleInResponse.Name
                Description = $UserRoleInResponse.description
            }
        }
        return $UserRoles | Where-Object { $PSItem.Name -Like $Name }
    }

}