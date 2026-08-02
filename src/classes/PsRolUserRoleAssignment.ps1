# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolUserRoleAssignment {
    [PsRolUser]$User
    [PsRolPostponedConstraint[]]$PostponedConstraints
    [PsRolUserRole]$UserRole
    [PsRolOrganisation]$ResponsibleOrgUnit
    [PsRolTitle]$AssignedThroughTitle
    [string]$AssignedThrough

    PsRolUserRoleAssignment() {
        $this.PostponedConstraints = [PsRolPostponedConstraint[]]::new()
    }

    PsRolUserRoleAssignment([object]$obj) {
        if ($obj.user) {
            $this.User = [PsRolUser]::new($obj.user)
        }
        if ($obj.postponedConstraints) {
            $this.PostponedConstraints = foreach ($pc in $obj.postponedConstraints) { [PsRolPostponedConstraint]::new($pc) }
        }
        if ($obj.userRole) {
            $this.UserRole = [PsRolUserRole]::new($obj.userRole)
        }
        if ($obj.responsibleOrgUnit) {
            $this.ResponsibleOrgUnit = [PsRolOrganisation]::new($obj.responsibleOrgUnit)
        }
        if ($obj.assignedThroughTitle) {
            $this.AssignedThroughTitle = [PsRolTitle]::new($obj.assignedThroughTitle)
        }
        $this.AssignedThrough = $obj.assignedThrough
    }
}
