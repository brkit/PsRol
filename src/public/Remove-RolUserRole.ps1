# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Remove-RolUserRole {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$UserRoleId
    )
    
    process {
        $ApiUrl = '/api/v2/userrole/{0}' -f $UserRoleId
        
        $UserRoleToDelete = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
        if ($null -eq $UserRoleToDelete) {
            throw "UserRole '$UserRoleId' not found."
        }

        if ($PSCmdlet.ShouldProcess("UserRole: '$($UserRoleToDelete.Name) ($UserRoleId)'", 'Delete')) {
            Invoke-ApiClient -Uri $ApiUrl -Method 'DELETE'
        }
    }

}