# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Test-RolUserRoleAssignment {
    [CmdletBinding(DefaultParameterSetName = 'ByProperties')]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$UserId,
        [string]$Domain = 'Administrativt',
        [Parameter(ParameterSetName = 'ByProperties', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$UserRoleId,
        [Parameter(ParameterSetName = 'ByProperties', ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(ParameterSetName = 'ByProperties', ValueFromPipelineByPropertyName)]
        [string]$Identifier
    )

    process {
        $ApiUrl = '/api/v2/user/{0}/assignments?domain={1}' -f $UserId, $Domain

        $AssignedRoles = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

        if (-not $AssignedRoles) {
            return $false
        }

        if (-not $UserRoleId -and -not $Name -and -not $Identifier) {
            Write-Error 'Missing parameter for testing user role assignment'
            return
        }

        foreach ($role in $AssignedRoles) {
            if (-not [string]::IsNullOrEmpty($UserRoleId)) {
                if ([string]$role.userRole.id -eq [string]$UserRoleId) { return $true }
            }

            if (-not [string]::IsNullOrEmpty($Identifier)) {
                if ($role.userRole.identifier -eq $Identifier) { return $true }
            }

            if (-not [string]::IsNullOrEmpty($Name)) {
                if ($role.userRole.name -like $Name) { return $true }
            }
        }

        return $false
    }
}
