# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolPostponedConstraint {
    [string]$Value
    [long]$ConstraintTypeId
    [string]$ConstraintTypeEntityId
    [long]$SystemRoleId

    PsRolPostponedConstraint() {}

    PsRolPostponedConstraint([object]$obj) {
        $this.Value = $obj.value
        if ($null -ne $obj.constraintTypeId) {
            $this.ConstraintTypeId = [long]$obj.constraintTypeId
        }
        $this.ConstraintTypeEntityId = $obj.constraintTypeEntityId
        if ($null -ne $obj.systemRoleId) {
            $this.SystemRoleId = [long]$obj.systemRoleId
        }
    }
}
