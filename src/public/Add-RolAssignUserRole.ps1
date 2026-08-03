# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolAssignUserRole {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByUserRoleId')]
    param (
        [Parameter(Mandatory, ParameterSetName = 'ByUserRoleId', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$UserRoleId,
        [Parameter(Mandatory, ParameterSetName = 'ByName')]
        [string]$Name,
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('SamAccountName')]
        [object]$UserId,
        [DateTime]$StartDate = (Get-Date),
        [DateTime]$StopDate,        
        # By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
        [string]$Domain = 'Administrativt',
        [switch]$AllowExtraAssignments
    )
    
    process {
        if ([string]::IsNullOrWhiteSpace($UserRoleId)) {
            $foundRoles = @(Get-RolUserRole -Name $Name)
            if ($foundRoles.Count -eq 0) {
                throw "UserRole with Name '$Name' not found."
            }
            if ($foundRoles.Count -gt 1) {
                $exactMatches = @($foundRoles | Where-Object { $_.Name -eq $Name })
                if ($exactMatches.Count -eq 1) {
                    $foundRoles = $exactMatches
                }
                else {
                    throw "Multiple user roles found with Name '$Name'. Please specify the Id instead."
                }
            }
            $UserRoleId = $foundRoles[0].UserRoleId
        }

        $ADUserType = 'Microsoft.ActiveDirectory.Management.ADUser' -as [type]
        $ADPrincipalType = 'Microsoft.ActiveDirectory.Management.ADPrincipal' -as [type]

        $isADUser = ($null -ne $ADUserType -and $UserId -is $ADUserType) -or ($UserId.PSTypeNames -contains 'Microsoft.ActiveDirectory.Management.ADUser')
        $isADPrincipal = ($null -ne $ADPrincipalType -and $UserId -is $ADPrincipalType) -or ($UserId.PSTypeNames -contains 'Microsoft.ActiveDirectory.Management.ADPrincipal')

        if ($isADUser) {
            $UserId = $UserId.SamAccountName
        }
        elseif ($isADPrincipal) {
            if ($UserId.objectClass -notcontains 'user') {
                Write-Warning "Skipping ADPrincipal '$($UserId.SamAccountName)', objectClass must be 'user'."
                return
            }
            $UserId = $UserId.SamAccountName
        }
        elseif ($null -ne $UserId.SamAccountName) {
            $UserId = $UserId.SamAccountName
        }

        $ApiUrl = '/api/v2/user/{0}/assign/userrole/{1}' -f $UserId, $UserRoleId

        $Request = [PSCustomObject]@{
            startDate            = $StartDate.ToString('yyyy-MM-dd')
            stopDate             = $StopDate ? $StopDate.ToString('yyyy-MM-dd') : ""
            domain               = $Domain
            onlyIfNotAssigned    = (-not $AllowExtraAssignments.IsPresent)
            postponedConstraints = @()
        }

        if ($PSCmdlet.ShouldProcess("User '$UserId' => UserRole '$UserRoleId'", 'Assign')) {
            Invoke-ApiClient -Uri $ApiUrl -Method 'PUT' -Body ($Request | ConvertTo-Json)
        }
    }

}