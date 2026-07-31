# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolRoleGroupUserRole {
    [string]$UserRoleId
    [string]$AssignedByUserId
    [string]$AssignedByName
    [DateTime]$AssignedTimestamp

    PsRolRoleGroupUserRole() {}

    PsRolRoleGroupUserRole([object]$obj) {
        $this.UserRoleId = $obj.userRoleId
        $this.AssignedByUserId = $obj.assignedByUserId
        $this.AssignedByName = $obj.assignedByName
        if ($obj.assignedTimestamp) {
            $this.AssignedTimestamp = [DateTime]$obj.assignedTimestamp
        }
    }
}
