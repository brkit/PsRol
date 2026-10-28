# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolRoleGroup {
    [string]$RoleGroupId
    [string]$Name
    [string]$Description
    [bool]$UsersOnly
    [bool]$CanRequest
    [PsRolRoleGroupUserRole[]]$UserRoles
    [PsRolApproverPermission[]]$ApproverPermission
    [PsRolRequesterPermission[]]$RequesterPermission

    PsRolRoleGroup() {}

    PsRolRoleGroup([object]$obj) {
        $this.RoleGroupId = $obj.id
        $this.Name = $obj.name
        $this.Description = $obj.description
        $this.UsersOnly = [bool]$obj.usersOnly
        $this.CanRequest = [bool]$obj.canRequest
        if ($obj.userRoles) {
            $this.UserRoles = foreach ($ur in $obj.userRoles) {
                [PsRolRoleGroupUserRole]::new($ur)
            }
        }
        if ($obj.approverPermission) {
            $this.ApproverPermission = foreach ($ap in $obj.approverPermission) {
                [PsRolApproverPermission]$ap
            }
        }
        if ($obj.requesterPermission) {
            $this.RequesterPermission = foreach ($rp in $obj.requesterPermission) {
                [PsRolRequesterPermission]$rp
            }
        }
    }

    [string] ToString() {
        return $this.Name
    }
}
