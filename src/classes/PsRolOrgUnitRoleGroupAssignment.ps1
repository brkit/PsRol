# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolOrgUnitRoleGroupAssignment {
    [string]$AssignmentType
    [long]$AssignmentId
    [bool]$Inherit
    [DateTime]$AssignedAt
    [string]$AssignedByName
    [string]$AssignedByUserId
    [DateTime]$StartDate
    [DateTime]$StopDate
    [PsRolOrganisation]$OrgUnit
    [PsRolRoleGroup]$RoleGroup
    [PsRolAssignmentScope[]]$Scopes

    PsRolOrgUnitRoleGroupAssignment() {
        $this.Scopes = @()
    }

    PsRolOrgUnitRoleGroupAssignment([object]$obj) {
        $this.AssignmentType = [string]$obj.assignmentType
        if ($null -ne $obj.assignmentId) { $this.AssignmentId = [long]$obj.assignmentId }
        if ($null -ne $obj.inherit) { $this.Inherit = [bool]$obj.inherit }
        if ($obj.assignedAt) { $this.AssignedAt = [DateTime]$obj.assignedAt }
        $this.AssignedByName = [string]$obj.assignedByName
        $this.AssignedByUserId = [string]$obj.assignedByUserId
        if ($obj.startDate) { $this.StartDate = [DateTime]$obj.startDate }
        if ($obj.stopDate) { $this.StopDate = [DateTime]$obj.stopDate }
        if ($obj.orgUnit) { $this.OrgUnit = [PsRolOrganisation]::new($obj.orgUnit) }
        if ($obj.roleGroup) { $this.RoleGroup = [PsRolRoleGroup]::new($obj.roleGroup) }
        if ($obj.scopes) {
            $this.Scopes = foreach ($s in $obj.scopes) { [PsRolAssignmentScope]::new($s) }
        }
        else {
            $this.Scopes = @()
        }
    }
}
