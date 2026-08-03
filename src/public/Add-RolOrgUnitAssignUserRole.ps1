# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolOrgUnitAssignUserRole {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$UserRoleId,
        [Parameter(Mandatory)]
        [string]$OrgUnitUuid,
        [DateTime]$StartDate = (Get-Date),
        [DateTime]$StopDate,
        [PsRolAssignmentScope[]]$Scope,
        [switch]$Inherit
    )
    
    process {
        $ApiUrl = '/api/v2/organisation/assignment/userrole'

        $Request = [PSCustomObject]@{
            assignmentType = 'USER_ROLE'
            inherit        = $Inherit.IsPresent
            scopes         = $Scope
            startDate      = $StartDate.ToString('yyyy-MM-dd')
            stopDate       = $StopDate ? $StopDate.ToString('yyyy-MM-dd') : ''
            orgUnit        = [PSCustomObject]@{
                uuid = $OrgUnitUuid
            }
            userRole       = [PSCustomObject]@{
                id = $UserRoleId
            }
        }
        
        if ($PSCmdlet.ShouldProcess(('UserRole ''{0}'' => OrgUnit ''{1}''' -f $UserRoleId, $OrgUnitUuid), 'Assign')) {
            Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Request | ConvertTo-Json)
        }
    }

}