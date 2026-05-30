# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolItSystemRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$itSystemId#,
        #[Parameter(Mandatory = $true)]
        #[string]$Name,
        #[Parameter(Mandatory = $True)]
        #[string]$Identifier,
        #[Parameter(Mandatory = $false)]
        #[string]$Description,
        #[Parameter(Mandatory = $false)]
        #[string]$Weight = 1
    )
    process {
        $CheckApiUrlPart = '/api/v2/itsystem/{0}/systemroles' -f $itSystemId
        

        $Response = Invoke-ApiClient -Uri $CheckApiUrlPart -Method 'GET' -Body ''
        
        $Response.PSForEach({ [PsRolSystemRole]::new($PSItem) })
        #
        #$DefaultDisplaySet = 'Name', 'SystemRoleIdentifier', 'Description'
        #$DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$defaultDisplaySet)
        #$PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
        #$ReturnObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers
        #
        #return $ReturnObject
    }
}