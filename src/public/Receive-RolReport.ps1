# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Receive-RolReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [datetime]$ReportDate,
        [string]$OutFile
    )

    
    $Body = [PSCustomObject]@{
        date              = $ReportDate.ToString('yyyy-MM-dd')
        managerFilter     = $null
        unitFilter        = @()
        itsystemFilter    = @()
        showUsers         = $false
        showOUs           = $false
        showUserRoles     = $true
        showNegativeRoles = $false
        showKLE           = $false
        showItSystems     = $false
        showInactiveUsers = $false
        showSystemRoles   = $false
    }

    $Response = Invoke-ApiClient -Uri '/api/v2/report' -Method 'POST' -Body ($Body | ConvertTo-Json) -OutFile $OutFile

    return $Response

}