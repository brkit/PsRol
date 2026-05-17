# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolAssignUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [String]$Name
    )
    
    process {
        $ApiUrl = '/api/v2/userrole'

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'PUT'
    }

}