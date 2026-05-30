# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolConstraintValue {
    [string]$ConstraintTypeId
    [string]$ConstraintTypeEntityId
    [string]$ConstraintValueType
    [string]$ConstraintValue
    [object]$ConstraintIdentifier
    [bool]$Postponed

    PsRolConstraintValue([object]$obj) {
        $this.ConstraintTypeId = $obj.constraintTypeId
        $this.ConstraintTypeEntityId = $obj.constraintTypeEntityId
        $this.ConstraintValueType = $obj.constraintValueType
        $this.ConstraintValue = $obj.constraintValue
        $this.ConstraintIdentifier = $obj.constraintIdentifier
        $this.Postponed = $obj.postponed
    }
}

class PsRolConstraintValueInput {
    [string]$ConstraintTypeEntityId
    [string]$ConstraintValue
}