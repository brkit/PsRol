# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolItSystemRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$itSystemId,
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $True)]
        [string]$Identifier,
        [Parameter(Mandatory = $false)]
        [string]$Description,
        [Parameter(Mandatory = $false)]
        [string]$Weight = 1
    )
    process {
        $CheckApiUrlPart = '/api/v2/itsystem/{0}' -f $itSystemId
        
        try {
            Invoke-ApiClient -Uri $CheckApiUrlPart -Method 'GET' -Body "" | Out-Null
        }
        catch {
            Throw $('It System with ItSystemId {0} not found.' -f $itSystemId)
        }
        
        $ApiQueryParams = $('?AdGroupType={0}&universal={1}' -f 'NONE', 'false')
        $ApiUrlPart = $('/api/v2/itsystem/{0}/systemroles' -f $itSystemId)
        $ApiUrl = $ApiUrlPart + $ApiQueryParams

        $Body = [PSCustomObject]@{
            id                       = 0
            name                     = $Name
            identifier               = $Identifier
            description              = $Description
            weight                   = $Weight
            supportedConstraintTypes = @()
        }

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json)
        
        $ReturnObject = [PsRolSystemRole]::new($Response)
        
        $DefaultDisplaySet = 'Name', 'SystemRoleIdentifier', 'Description'
        $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$defaultDisplaySet)
        $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
        $ReturnObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers

        return $ReturnObject
    }
}