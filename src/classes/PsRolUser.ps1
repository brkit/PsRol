# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolUser {
    [guid]$Uuid
    [string]$UserId
    [guid]$ExtUuid
    [string]$Name
    # It seems users also have an old, deprecated extId parameter, no module command use this currently, so it is not provided by this type

    PsRolUser() {}

    PsRolUser([object]$obj) {
        $this.Uuid = [guid]$obj.uuid
        $this.UserId = $obj.userId
        $this.ExtUuid = [guid]$obj.extUuid
        $this.Name = $obj.name
    }

    [string] ToString() {
        return '{0} ({1})' -f $this.Name, $this.UserId
    }
}
