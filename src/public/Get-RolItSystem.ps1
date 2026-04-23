# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolItSystem {
    [CmdletBinding()]
    param (
        [string]$itSystemId,
        [string]$Name,
        [string]$Identifier,
        [switch]$All
    )

    if ($null -ne $itSystemId) {
        $ApiUrlPart = '/api/v2/itsystem/' + $itSystemId
    }
    else {
        $ApiUrlPart = '/api/v2/itsystem'
    }
    $ApiMethod = 'GET'

    $Response = Invoke-ApiClient -Uri $ApiUrlPart -Method $ApiMethod -Body ""
    
    $ReturnObject = @()
    
    if ($All.IsPresent) { 
        $itSystems = $Response
    }
    else {
        $itSystems = $Response.PSWhere({ $PSItem.canEditThroughApi })
    }

    if ($null -ne $Name) {
        $itSystems = $itSystems.PSWhere({ $PSItem.Name -match $Name })
    }

    if ($null -ne $Identifier) {
        $itSystems = $itSystems.PSWhere({ $PSItem.identifier -match $Identifier })
    }

    foreach ($itSystem in $itSystems) { 
        $ReturnObject += [PSCustomObject]@{
            ItSystemId     = $itSystem.Id
            Name           = $itSystem.name
            Identifier     = $itSystem.identifier
            SystemType     = $itSystem.systemtype
            Paused         = $itSystem.paused
            Hidden         = $itSystem.hidden
            ReadOnly       = $itSystem.readonly
            ApiMaintanable = $itSystem.canEditThroughApi
            Deleted        = $itSystem.deleted
            #AccesBlocked = $itSystem.accesBlocked
            #apiManagedRoleAssignments = $itSystem.apiManagedRoleAssignments
            Domain         = $itSystem.domain
            Email          = $itSystem.email
            #responsibleUserUuid = $itSystem.responsibleUserUuid
        }
    }
    
    if ($ReturnObject.Count -gt 1) {
        $ReturnObject.PSObject.TypeNames.Insert(0, 'PsRol.ItSystem')
        $DefaultDisplaySet = 'ItSystemId', 'Name', 'Identifier', 'SystemType'
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$defaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
        $ReturnObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers
    }

    return $ReturnObject
}