# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolSystemRoleAssignment {
    [string]$SystemRoleId
    [string]$SystemRoleIdentifier
    [System.Collections.Generic.List[PsRolConstraintValue]]$ConstraintValues

    PsRolSystemRoleAssignment() {
        $this.ConstraintValues = [System.Collections.Generic.List[PsRolConstraintValue]]::new()
    }
    PsRolSystemRoleAssignment([object]$obj) {
        $this.SystemRoleId = $obj.systemRoleId
        $this.SystemRoleIdentifier = $obj.systemRoleIdentifier
        $this.ConstraintValues = [System.Collections.Generic.List[PsRolConstraintValue]]::new()
        if ($obj.constraintValues) {
            foreach ($val in $obj.constraintValues) {
                $this.ConstraintValues.Add([PsRolConstraintValue]::new($val))
            }
        }
    }

}