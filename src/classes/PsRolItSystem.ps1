# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolItSystem {
    [string]$ItSystemId
    [string]$Name
    [string]$Identifier
    [PsRolItSystemType]$SystemType
    [bool]$Paused
    [bool]$Hidden
    [bool]$ReadOnly
    [bool]$ApiMaintanable
    [bool]$Deleted
    [string]$Domain
    [string]$Email

    PsRolItSystem() {}

    PsRolItSystem([object]$obj) {
        $this.ItSystemId = [string]$obj.id
        $this.Name = [string]$obj.name
        $this.Identifier = [string]$obj.identifier
        $this.SystemType = [PsRolItSystemType]$obj.systemtype
        $this.Paused = [bool]$obj.paused
        $this.Hidden = [bool]$obj.hidden
        $this.ReadOnly = [bool]$obj.readonly
        $this.ApiMaintanable = [bool]$obj.canEditThroughApi
        $this.Deleted = [bool]$obj.deleted
        $this.Domain = [string]$obj.domain
        $this.Email = [string]$obj.email
    }
}
