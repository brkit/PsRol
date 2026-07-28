# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolOrgUnitAssignUserGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$RoleGroupId,
        [Parameter(Mandatory = $true)]
        [String]$OrgUnitUuid,
        [Parameter(Mandatory = $false)]
        [DateTime]$StartDate = (Get-Date),
        [Parameter(Mandatory = $false)]
        [DateTime]$StopDate,
        [Parameter(Mandatory = $false)]
        [PsRolAssignmentScope[]]$Scope,
        [Switch]$Inherit
    )
    
    process {
        $ApiUrl = '/api/v2/organisation/assignment/rolegroup'

        $Request = [PSCustomObject]@{
            assignmentType = 'ROLE_GROUP'
            inherit        = $Inherit.IsPresent
            scopes         = $Scope
            startDate      = $StartDate.ToString('yyyy-MM-dd')
            stopDate       = $StopDate ? $StopDate.ToString('yyyy-MM-dd') : ''
            orgUnit        = [PSCustomObject]@{
                uuid = $OrgUnitUuid
            }
            roleGroup      = [PSCustomObject]@{
                id = $RoleGroupId
            }
        }
        
        # Use -EnumAsStrings or the enum gets translated to its integer representation
        Invoke-ApiClient -Uri $ApiUrl -Method 'Post' -Body ($Request | ConvertTo-Json -EnumsAsStrings -Depth 4)
    }

}