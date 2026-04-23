# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]    
        [String]$Name,
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [String]$Description,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$ItSystemId,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [string[]]$SystemRoleId,
        [switch]$SensitiveRole
    )
    
    process {
        $ApiUrl = '/api/v2/userrole'

        $systemRoleAssignments = @()
        $systemRoleAssignments = $SystemRoleId.PSForEach({
                [PSCustomObject]@{
                    systemRoleId         = $PSItem
                    systemRoleIdentifier = $null
                    constraintValues     = @()
                }
            })

        $Body = [PSCustomObject]@{
            name                  = $Name
            identifier            = $('id-{0}' -f ([Guid]::NewGuid()).Guid)
            description           = $Description
            delegatedFromCvr      = $null
            userOnly              = $false
            sensitiveRole         = $SensitiveRole.IsPresent
            itSystemId            = $ItSystemId
            systemRoleAssignments = $systemRoleAssignments
            requesterPermission   = @('INHERIT')
            approverPermission    = @('INHERIT')  
        }
        
        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json -Depth 3)
        return $Response
    
    }

}