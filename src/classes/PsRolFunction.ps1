# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolFunction {
    [string]$name
    [string]$uuid

    PsRolFunction() {}
    
    PsRolFunction([object]$obj) {
        $this.name = $obj.name
        $this.uuid = $obj.uuid
    }
}