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
        [Alias('Name')]
        [string]$UserRoleName,
        [Parameter(ParameterSetName = 'ByProperties', ValueFromPipelineByPropertyName)]
        [Alias('Identifier')]
        [string]$UserRoleIdentifier
    )

    process {
        $ApiUrl = '/api/v2/user/{0}/assignments?domain={1}' -f $UserId, $Domain

        $AssignedRoles = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

        if (-not $AssignedRoles) {
            return $false
        }

        if (-not $UserRoleId -and -not $UserRoleName -and -not $UserRoleIdentifier) {
            Write-Error 'Missing parameter for testing user role assignment'
            return
        }

        foreach ($role in $AssignedRoles) {
            if (-not [string]::IsNullOrEmpty($UserRoleId)) {
                if ([string]$role.userRole.id -eq [string]$UserRoleId) { return $true }
            }

            if (-not [string]::IsNullOrEmpty($UserRoleIdentifier)) {
                if ($role.userRole.identifier -eq $UserRoleIdentifier) { return $true }
            }

            if (-not [string]::IsNullOrEmpty($UserRoleName)) {
                if ($role.userRole.name -like $UserRoleName) { return $true }
            }
        }

        return $false
    }
}
