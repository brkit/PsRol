# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolTitle {
    [CmdletBinding()]
    [OutputType([PsRolTitle])]
    param (
        [AllowEmptyString()]
        [string]$Name
    )
    
    process {
        $ApiUrl = '/api/title'

        $TitleResponse = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
        $Titles = foreach ($TitleInResponse in $TitleResponse) {
            [PsRolTitle]::new($TitleInResponse)
        }
        
        if ([string]::IsNullOrWhiteSpace($Name)) {
            return $Titles
        }
        else {
            return $Titles | Where-Object { $PSItem.Name -Like $Name }
        }
    }

}