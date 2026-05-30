# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolOrganisation {
    [string]$Name
    [string]$Uuid

    PsRolOrganisation() {}
    
    PsRolOrganisation([object]$obj) {
        $this.Name = $obj.name
        $this.Uuid = $obj.uuid
    }
}