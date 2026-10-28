# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolUserRole {
    [CmdletBinding()]
    [OutputType([PsRolUserRole])]
    param (
        [Alias('Id')]
        [string]$UserRoleId,
        [AllowEmptyString()]
        [string]$Name
    )
    
    process {
        if (-not [string]::IsNullOrWhiteSpace($UserRoleId)) {
            $ApiUrl = '/api/v2/userrole/{0}' -f $UserRoleId
            $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
            if ($null -eq $Response) {
                return $null
            }
            $UserRoles = foreach ($UserRoleInResponse in @($Response)) {
                [PsRolUserRole]::new($UserRoleInResponse)
            }
            if ($null -ne $UserRoles) {
                Set-DefaultDisplayPropertySet -InputObject $UserRoles -Properties 'UserRoleId', 'Name', 'Description'
                return $UserRoles
            }
            return $null
        }

        $timeoutSeconds = if ($null -ne $Script:CacheTimeoutSeconds) { $Script:CacheTimeoutSeconds } else { 30 }
        $isExpired = ($null -eq $Script:UserRoleCache) -or 
        ($null -eq $Script:UserRoleCacheTime) -or 
        ((Get-Date) - $Script:UserRoleCacheTime).TotalSeconds -ge $timeoutSeconds

        if ($isExpired) {
            $ApiUrl = '/api/v2/userrole'

            $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
            $Script:UserRoleCache = foreach ($UserRoleInResponse in $Response) {
                [PsRolUserRole]::new($UserRoleInResponse)
            }
            $Script:UserRoleCacheTime = Get-Date
        }

        $UserRoles = $Script:UserRoleCache

        if (-not [string]::IsNullOrWhiteSpace($Name)) {
            $UserRoles = $UserRoles | Where-Object { $PSItem.Name -Like $Name }
        }
        if ($null -ne $UserRoles) {
            Set-DefaultDisplayPropertySet -InputObject $UserRoles -Properties 'UserRoleId', 'Name', 'Description'
            return $UserRoles
        }

        return $null
    }
}