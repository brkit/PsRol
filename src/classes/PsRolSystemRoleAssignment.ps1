# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolSystemRoleAssignment {
    [string]$SystemRoleId
    [string]$SystemRoleIdentifier
    [PsRolConstraintValue[]]$ConstraintValues

    PsRolSystemRoleAssignment() {
        $this.ConstraintValues = [PsRolConstraintValue[]]::new()
    }
    PsRolSystemRoleAssignment([object]$obj) {
        $this.SystemRoleId = $obj.systemRoleId
        $this.SystemRoleIdentifier = $obj.systemRoleIdentifier
        if ($obj.constraintValues) {
            $this.ConstraintValues = foreach ($val in $obj.constraintValues) { [PsRolConstraintValue]::new($val) }
        }
    }

}