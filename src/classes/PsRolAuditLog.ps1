# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolAuditLog {
    [long]$Id
    [DateTime]$Timestamp
    [string]$IpAddress
    [string]$Username
    [string]$EntityType
    [string]$EntityId
    [string]$EntityName
    [string]$EventType
    [string]$SecondaryEntityType
    [string]$SecondaryEntityId
    [string]$SecondaryEntityName
    [string]$Description

    PsRolAuditLog() {}

    PsRolAuditLog([object]$obj) {
        $this.Id = [long]$obj.id
        if ($obj.timestamp) {
            $this.Timestamp = [DateTime]$obj.timestamp
        }
        $this.IpAddress = [string]$obj.ipAddress
        $this.Username = [string]$obj.username
        $this.EntityType = [string]$obj.entityType
        $this.EntityId = [string]$obj.entityId
        $this.EntityName = [string]$obj.entityName
        $this.EventType = [string]$obj.eventType
        $this.SecondaryEntityType = [string]$obj.secondaryEntityType
        $this.SecondaryEntityId = [string]$obj.secondaryEntityId
        $this.SecondaryEntityName = [string]$obj.secondaryEntityName
        $this.Description = [string]$obj.description
    }
}
