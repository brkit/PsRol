# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolFunction {
    [string]$name
    [guid]$uuid

    PsRolFunction() {}
    
    PsRolFunction([object]$obj) {
        $this.name = [string]$obj.name
        $this.uuid = [guid]$obj.uuid
    }

    [string] ToString() {
        return $this.name
    }
}