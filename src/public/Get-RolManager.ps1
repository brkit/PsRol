# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolManager {
    [CmdletBinding()]
    param (
    )
    
    $ApiUrl = '/api/v2/manager'

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'Get' -Body ''

    $ReturnObject = @()
    foreach ($Manager in $Response) { 
        $ReturnObject += [PsRolManager]$Manager
    }
    
    return $ReturnObject

}