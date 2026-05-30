# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolSystemRole {
    [int]$SystemRoleId
    [string]$Name
    [string]$SystemRoleIdentifier
    [string]$Description
    [int]$Weight
    [PsRolSupportedConstraintTypes[]]$SupportedConstraintTypes

    PsRolSystemRole() {}

    PsRolSystemRole([object]$obj) {
        $this.SystemRoleId = $obj.id
        $this.Name = $obj.name
        $this.SystemRoleIdentifier = $obj.identifier
        $this.Description = $obj.description
        $this.Weight = $obj.weight
        #$this.SupportedConstraintTypes = $obj.supportedConstraintTypes
        if ($obj.supportedConstraintTypes) {
            $this.SupportedConstraintTypes = foreach ($supportedConstraintType in $obj.supportedConstraintTypes) { [PsRolSupportedConstraintTypes]::new($supportedConstraintType) }
        }
    }
}

class PsRolSupportedConstraintTypes {
    [PsRolConstraintType[]]$ConstraintType
    [bool]$Mandatory

    PsRolSupportedConstraintTypes() {}

    PsRolSupportedConstraintTypes([object]$obj) {
        $this.Mandatory = $obj.mandatory
        if ($obj.constraintType) {
            $this.ConstraintType = foreach ($constraintTypeSingle in $obj.constraintType) { [PsRolConstraintType]::new($constraintTypeSingle) }
        }
    }

}
class PsRolConstraintType {
    [string]$ConstraintTypeId
    [string]$ConstraintTypeUuid
    [string]$ConstraintTypeEntityId
    [string]$ConstraintTypeName
    [string]$ConstraintTypeDescription
    [string]$ConstraintTypeUiType
    [string]$ConstraintTypeRegex    
    
    PsRolConstraintType() {}

    PsRolConstraintType([object]$obj) {
        $this.ConstraintTypeId = $obj.id
        $this.ConstraintTypeUuid = $obj.uuid
        $this.ConstraintTypeEntityId = $obj.entityId
        $this.ConstraintTypeName = $obj.name
        $this.ConstraintTypeDescription = $obj.description
        $this.ConstraintTypeUiType = $obj.uiType
        $this.ConstraintTypeRegex = $obj.regex
    }

}