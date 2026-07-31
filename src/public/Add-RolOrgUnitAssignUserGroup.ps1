# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolOrgUnitAssignUserGroup {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$RoleGroupId,
        [Parameter(Mandatory)]
        [string]$OrgUnitUuid,
        [DateTime]$StartDate = (Get-Date),
        [DateTime]$StopDate,
        [PsRolAssignmentScope[]]$Scope,
        [switch]$Inherit
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
        
        # Use -EnumsAsStrings or the enum gets translated to its integer representation
        if ($PSCmdlet.ShouldProcess("RoleGroup '$RoleGroupId' => OrgUnit '$OrgUnitUuid'", 'Assign')) {
            Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Request | ConvertTo-Json -EnumsAsStrings -Depth 4)
        }
    }

}