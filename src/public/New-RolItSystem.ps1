# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolItSystem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [string]$SystemIdentifier,
        [Parameter(Mandatory = $true)]
        [PsRolItSystemType]$ItSystemType,
        [switch]$Paused,
        [switch]$Hidden,
        [switch]$Readonly,

        # By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
        # Creating an argument completer instead of an enum ensures tab-completion between the two conventional values, but doesn't cause validation so other values can be specified manually.
        [Parameter(Mandatory = $false)]
        [ArgumentCompleter( {
                param ( $commandName,
                    $parameterName,
                    $wordToComplete,
                    $commandAst,
                    $fakeBoundParameters )
                $domains = @('Administrativt', 'Skole') | Where-Object { $PSItem -Like "$wordToComplete*" }
                $domains | ForEach-Object { New-Object -Type System.Management.Automation.CompletionResult -ArgumentList @(
                        $PSItem
                        $PSItem
                        'ParameterValue'
                        $PSItem
                    )
                }
            })]
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

    $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json -Depth 3)

    return $Response
}