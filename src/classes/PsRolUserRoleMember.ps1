# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolUserRoleMember {
    hidden [guid]$Uuid
    [string]$UserId
    hidden [guid]$ExtUuid
    [string]$Name
    hidden [string]$ExtId

    PsRolUserRoleMember() {}

    PsRolUserRoleMember([object]$obj) {
        $this.Uuid = [guid]$obj.uuid
        $this.UserId = $obj.userId
        $this.ExtUuid = [guid]$obj.extUuid
        $this.Name = $obj.name
        $this.ExtId = $obj.extId
    }
}