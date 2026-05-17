# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolManagerSubstitute {
    hidden [guid]$Uuid
    [string]$UserId
    [string]$Name
    hidden [string]$OrgUnitUuid
    [string]$OrgUnitName

    PsRolManagerSubstitute() {}

    PsRolManagerSubstitute([object]$obj) {
        $this.Uuid = [guid]$obj.uuid
        $this.UserId = [string]$obj.userId
        $this.Name = [string]$obj.name
        $this.OrgUnitUuid = [string]$obj.orgUnitUuid
        $this.OrgUnitName = [string]$obj.orgUnitName
    }
}

class PsRolManager {
    hidden [guid]$Uuid
    [string]$UserId
    [string]$Name
    [PsRolManagerSubstitute[]]$Substitutes

    PsRolManager() {}

    PsRolManager([object]$obj) {
        $this.Uuid = [guid]$obj.uuid
        $this.UserId = [string]$obj.userId
        $this.Name = [string]$obj.name
        if ($obj.managerSubstitutes) {
            $this.Substitutes = foreach ($substitute in $obj.managerSubstitutes) { [PsRolManagerSubstitute]::new($substitute) }
        }
    }
}