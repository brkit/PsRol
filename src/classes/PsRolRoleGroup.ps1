# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolRoleGroup {
    [string]$RoleGroupId
    [string]$Name
    [string]$Description
    [bool]$UsersOnly
    [bool]$CanRequest
    [PsRolRoleGroupUserRole[]]$UserRoles

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
    }
}
