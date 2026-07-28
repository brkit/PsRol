# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolTitle {
    [string]$name
    [string]$uuid

    PsRolTitle() {}
    
    PsRolTitle([object]$obj) {
        $this.Name = $obj.name
        $this.Uuid = $obj.uuid
    }
}