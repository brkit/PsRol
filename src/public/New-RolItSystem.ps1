# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolItSystem {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$SystemIdentifier,
        [Parameter(Mandatory)]
        [PsRolItSystemType]$ItSystemType,
        [switch]$Paused,
        [switch]$Hidden,
        [switch]$Readonly,

        # By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
        [string]$Domain = 'Administrativt'
    )
    $ApiUrl = '/api/v2/itsystem'
    $Body = [PSCustomObject]@{
        id                        = 0
        name                      = $Name
        identifier                = $SystemIdentifier
        systemtype                = $ItSystemType
        paused                    = $Paused.IsPresent
        hidden                    = $Hidden.IsPresent
        readonly                  = $Readonly.IsPresent
        canEditThroughApi         = $true
        deleted                   = $false
        accesBlocked              = $false
        apiManagedRoleAssignments = $false
        domain                    = $Domain
        email                     = $null
        responsibleUserUuid       = $null
    }
    if ($ItSystemType -eq [PsRolItSystemType]::AD -And -not $Paused.IsPresent) {
        Write-Warning -Message 'Systems of type ''AD'' are paused on creation'
    }

    if ($PSCmdlet.ShouldProcess(('ItSystem ''{0}'' ({1})' -f $Name, $SystemIdentifier), 'Create')) {
        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json -Depth 3)
        return $Response
    }
}