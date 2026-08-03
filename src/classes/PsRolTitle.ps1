# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolTitle {
    [string]$name
    [guid]$uuid

    PsRolTitle() {}
    
    PsRolTitle([object]$obj) {
        $this.name = $obj.name
        $this.uuid = [guid]$obj.uuid
    }
}