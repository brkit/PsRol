# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolAssignUserRole {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]$UserRoleId,
        [Parameter(Mandatory)]
        [string]$UserId,
        [DateTime]$StartDate = (Get-Date),
        [DateTime]$StopDate,        
        # By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
        [string]$Domain = 'Administrativt',
        [switch]$AllowExtraAssignments
    )
    
    process {
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