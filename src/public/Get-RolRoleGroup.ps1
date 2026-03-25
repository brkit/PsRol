# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolRoleGroup {
    [CmdletBinding()]
    param (
        
    )
    
    $ApiUrl = '/api/v2/rolegroup'

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'Get' -Body ''

    $RoleGroups = $Response
    $ReturnObject = @()

    foreach ($RoleGroup in $RoleGroups) {
        $UserRoles = @()
        foreach ($UserRole in $RoleGroup.userRoles) {
            $UserRoles += [PSCustomObject]@{
                UserRoleId        = $UserRole.userRoleId
                AssignedByUserId  = $UserRole.assignedByUserId
                AssignedByName    = $UserRole.assignedByName
                AssignedTimestamp = (Get-Date $UserRole.assignedTimestamp)
            }
        }
        $ReturnObject += [PSCustomObject]@{
            RoleGroupId = $RoleGroup.id
            Name        = $RoleGroup.name
            Description = $RoleGroup.description
            UsersOnly   = $RoleGroup.usersOnly
            CanRequest  = $RoleGroup.canRequest
            UserRoles   = $UserRoles
        }
    }
    
    if ($ReturnObject.Count -gt 1) {
        $ReturnObject.PSObject.TypeNames.Insert(0, 'PsRol.RoleGroup')
        $DefaultDisplaySet = 'Name', 'Description', 'UserRoles'
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$defaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
        $ReturnObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    }

    return $ReturnObject

}