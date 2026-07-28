# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolTitle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [String]$Name
    )
    
    process {
        $ApiUrl = '/api/title'

        $TitleResponse = Invoke-ApiClient -Uri $ApiUrl -Method 'GET' -Body ($Body | ConvertTo-Json -Depth 3)
        $Titles = @()
        $Titles += foreach ($TitleInResponse in $TitleResponse) {
            [PsRolTitle]::new($TitleInResponse)
        }
        
        if ([String]::IsNullOrWhiteSpace($Name)) {
            return $Titles
        }
        else {
            return $Titles | Where-Object { $PSItem.Name -Like $Name }
        }
    }

}