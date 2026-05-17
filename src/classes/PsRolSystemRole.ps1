# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolSystemRole {
    [int]$SystemRoleId
    [string]$Name
    [string]$SystemRoleIdentifier
    [string]$Description
    [int]$Weight
    [string[]]$SupportedConstraintTypes

    PsRolSystemRole() {}

    PsRolSystemRole([object]$obj) {
        $this.SystemRoleId = $obj.id
        $this.Name = $obj.name
        $this.SystemRoleIdentifier = $obj.identifier
        $this.Description = $obj.description
        $this.Weight = $obj.weight
        $this.SupportedConstraintTypes = $obj.supportedConstraintTypes
    }
}