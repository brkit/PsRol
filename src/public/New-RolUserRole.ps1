# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolUserRole {
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
        [PsRolSystemRoleAssignment[]]$SystemRoleAssignment,
        [switch]$SensitiveRole
    )
    
    process {
        $ApiUrl = '/api/v2/userrole'
        $SystemRoles = Get-RolItSystemRole -itSystemId $ItSystemId

        $sra = @()
        $sra = $SystemRoleAssignment.PSForEach({
                [PSCustomObject]@{
                    systemRoleId         = $PSItem.SystemRoleId
                    systemRoleIdentifier = $null
                    constraintValues     = @( $PSItem.ConstraintValues.PSForEach({
                                [PSCustomObject]@{
                                    constraintTypeId       = $PSItem.ConstraintTypeId
                                    constraintTypeEntityId = $PSItem.ConstraintTypeEntityId
                                    constraintValueType    = $PSItem.constraintValueType
                                    constraintValue        = $PSItem.ConstraintValue
                                    constraintIdentifier   = $PSItem.ConstraintIdentifier
                                    postponed              = $PSItem.Postponed
                                } 
                            }))
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
            systemRoleAssignments = $sra
            requesterPermission   = @('INHERIT')
            approverPermission    = @('INHERIT')  
        }
        
        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json -Depth 5)
        return $Response
    
    }

}