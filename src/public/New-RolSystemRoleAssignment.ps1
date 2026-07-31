# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolSystemRoleAssignment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification='Cmdlet does not modify system state')]
    [CmdletBinding()]
    [OutputType([PsRolSystemRoleAssignment])]
    param (
        [Parameter(Mandatory)]
        [string]$SystemRoleId,
        [PsRolConstraintValue[]]$ConstraintValues
    )

    process {
        
        [PsRolSystemRoleAssignment] @{
            SystemRoleId         = $SystemRoleId
            SystemRoleIdentifier = $null
            ConstraintValues     = $ConstraintValues
        }
    }
}
