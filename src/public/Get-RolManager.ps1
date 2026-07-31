# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolManager {
    [CmdletBinding()]
    [OutputType([PsRolManager])]
    param (
    )
    
    $ApiUrl = '/api/v2/manager'

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

    $ReturnObject = foreach ($Manager in $Response) { 
        [PsRolManager]$Manager
    }
    
    return $ReturnObject

}