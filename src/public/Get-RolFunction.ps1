# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolFunction {
    [CmdletBinding()]
    [OutputType([PsRolFunction])]
    param (
        [AllowEmptyString()]
        [string]$Name
    )
    
    process {
        $ApiUrl = '/api/v2/function'

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
        $Functions = foreach ($FunctionInResponse in $Response) {
            [PsRolFunction]::new($FunctionInResponse)
        }
        
        if ([string]::IsNullOrWhiteSpace($Name)) {
            return $Functions
        }
        else {
            return $Functions | Where-Object { $PSItem.Name -Like $Name }
        }
    }

}