# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolOrgUnitAssignUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$UserRoleId,
        [Parameter(Mandatory = $true)]
        [String]$OrgUnitUuid,
        [Parameter(Mandatory = $false)]
        [DateTime]$StartDate = (Get-Date),
        [Parameter(Mandatory = $false)]
        [DateTime]$StopDate,
        [Switch]$Inherit
    )
    
    process {
        $ApiUrl = '/api/v2/organisation/assignment/userrole'

        $Request = [PSCustomObject]@{
            assignmentType = "USER_ROLE"
            inherit        = $Inherit.IsPresent
            scopes         = $null
            startDate      = $StartDate.ToString('yyyy-MM-dd')
            stopDate       = $StopDate ? $StopDate.ToString('yyyy-MM-dd') : ""
            orgUnit        = [PSCustomObject]@{
                uuid = $OrgUnitUuid
            }
            userRole       = [PSCustomObject]@{
                id = $UserRoleId
            }
        }
        
        Invoke-ApiClient -Uri $ApiUrl -Method 'Post' -Body ($Request | ConvertTo-Json)
    }

}