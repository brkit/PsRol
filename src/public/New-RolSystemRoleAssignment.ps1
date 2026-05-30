# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolSystemRoleAssignment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
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
