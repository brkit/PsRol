# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
class PsRolUserRole {
    [long]$UserRoleId
    [long]$Id
    [string]$Name
    [string]$Identifier
    [string]$Description
    [string]$DelegatedFromCvr
    [bool]$UserOnly
    [bool]$CanRequest
    [bool]$SensitiveRole
    [long]$ItSystemId
    [string]$ContactEmail
    [string]$AdvisEmail
    [bool]$OuFilterEnabled
    [bool]$RoleAssignmentAttestationByAttestationResponsible
    [bool]$ExtraSensitiveRole
    [bool]$AllowPostponing
    [PsRolSystemRoleAssignment[]]$SystemRoleAssignments
    [PsRolOrganisation[]]$OrgUnitFilterOrgUnits
    [string[]]$RequesterPermission
    [string[]]$ApproverPermission

    PsRolUserRole() {
        $this.SystemRoleAssignments = [PsRolSystemRoleAssignment[]]::new()
        $this.OrgUnitFilterOrgUnits = [PsRolOrganisation[]]::new()
        $this.RequesterPermission = [string[]]::new()
        $this.ApproverPermission = [string[]]::new()
    }

    PsRolUserRole([object]$obj) {
        $idVal = if ($null -ne $obj.UserRoleId) { $obj.UserRoleId } else { $obj.id }
        if ($null -ne $idVal) {
            $this.UserRoleId = [long]$idVal
            $this.Id = [long]$idVal
        }
        $this.Name = $obj.name
        $this.Identifier = $obj.identifier
        $this.Description = $obj.description
        $this.DelegatedFromCvr = $obj.delegatedFromCvr
        if ($null -ne $obj.userOnly) { $this.UserOnly = [bool]$obj.userOnly }
        if ($null -ne $obj.canRequest) { $this.CanRequest = [bool]$obj.canRequest }
        if ($null -ne $obj.sensitiveRole) { $this.SensitiveRole = [bool]$obj.sensitiveRole }
        if ($null -ne $obj.itSystemId) { $this.ItSystemId = [long]$obj.itSystemId }
        $this.ContactEmail = $obj.contactEmail
        $this.AdvisEmail = $obj.advisEmail
        if ($null -ne $obj.ouFilterEnabled) { $this.OuFilterEnabled = [bool]$obj.ouFilterEnabled }
        if ($null -ne $obj.roleAssignmentAttestationByAttestationResponsible) { $this.RoleAssignmentAttestationByAttestationResponsible = [bool]$obj.roleAssignmentAttestationByAttestationResponsible }
        if ($null -ne $obj.extraSensitiveRole) { $this.ExtraSensitiveRole = [bool]$obj.extraSensitiveRole }
        if ($null -ne $obj.allowPostponing) { $this.AllowPostponing = [bool]$obj.allowPostponing }

        if ($obj.systemRoleAssignments) {
            $this.SystemRoleAssignments = foreach ($sra in $obj.systemRoleAssignments) { [PsRolSystemRoleAssignment]::new($sra) }
        }

        if ($obj.orgUnitFilterOrgUnits) {
            $this.OrgUnitFilterOrgUnits = foreach ($ou in $obj.orgUnitFilterOrgUnits) { [PsRolOrganisation]::new($ou) }
        }

        if ($obj.requesterPermission) {
            $this.RequesterPermission = foreach ($rp in $obj.requesterPermission) { [string]$rp }
        }

        if ($obj.approverPermission) {
            foreach ($ap in $obj.approverPermission) {
                $this.ApproverPermission = [string]$ap
            }
        }
    }

    [string] ToString() {
        return $this.Name
    }
}
