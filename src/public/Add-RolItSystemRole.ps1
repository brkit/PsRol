# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolItSystemRole {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([PsRolSystemRole])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ItSystemId,
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$Identifier,
        [string]$Description,
        [int]$Weight = 1
    )
    process {
        $CheckApiUrlPart = '/api/v2/itsystem/{0}' -f $ItSystemId
        
        try {
            Invoke-ApiClient -Uri $CheckApiUrlPart -Method 'GET' | Out-Null
        }
        catch {
            throw $('It System with ItSystemId {0} not found.' -f $ItSystemId)
        }
        
        $ApiQueryParams = $('?AdGroupType={0}&universal={1}' -f 'NONE', 'false')
        $ApiUrlPart = $('/api/v2/itsystem/{0}/systemroles' -f $ItSystemId)
        $ApiUrl = $ApiUrlPart + $ApiQueryParams

        $Body = [PSCustomObject]@{
            id                       = 0
            name                     = $Name
            identifier               = $Identifier
            description              = $Description
            weight                   = $Weight
            supportedConstraintTypes = @()
        }

        if ($PSCmdlet.ShouldProcess(('SystemRole ''{0}'' on ItSystem ''{1}''' -f $Name, $ItSystemId), 'Create')) {
            $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'POST' -Body ($Body | ConvertTo-Json)
        
            $ReturnObject = [PsRolSystemRole]::new($Response)
        
            Set-DefaultDisplayPropertySet -InputObject $ReturnObject -Properties 'Name', 'SystemRoleIdentifier', 'Description'

            return $ReturnObject
        }
    }
}