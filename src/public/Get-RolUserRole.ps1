# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [String]$Name
    )
    
    process {
        $ApiUrl = '/api/v2/userrole'

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET' -Body ($Body | ConvertTo-Json -Depth 3)
        $UserRoles = @()
        $UserRoles += foreach ($UserRoleInResponse in $Response) {
            [PSCustomObject]@{
                UserRoleId  = $UserRoleInResponse.id
                Name        = $UserRoleInResponse.Name
                Description = $UserRoleInResponse.description
            }
        }
        return $UserRoles | Where-Object { $PSItem.Name -Like $Name }
    }

}