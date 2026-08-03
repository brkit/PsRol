# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolOrganisation {
    [string]$Name
    [guid]$Uuid

    PsRolOrganisation() {}
    
    PsRolOrganisation([object]$obj) {
        $this.Name = $obj.name
        $this.Uuid = [guid]$obj.uuid
    }

    [string] ToString() {
        return $this.Name

    }
}