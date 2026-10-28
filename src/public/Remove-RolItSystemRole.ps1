# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Remove-RolItSystemRole {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$ItSystemId,
        [Parameter(Mandatory)]
        [string]$SytemRoleId
    )
    process {
        $CheckApiUrlPart = '/api/v2/itsystem/{0}' -f $ItSystemId
        
        try {
            Invoke-ApiClient -Uri $CheckApiUrlPart -Method 'GET' | Out-Null
        }
        catch {
            throw $('It System with ItSystemId {0} not found.' -f $ItSystemId)
        }
        
        $ApiUrlPart = $('/api/v2/itsystem/{0}/systemroles/{1}' -f $ItSystemId, $SytemRoleId)
        $ApiUrl = $ApiUrlPart + $ApiQueryParams
        
        if ($PSCmdlet.ShouldProcess(('SystemRole ''{0}'' on ItSystem ''{1}''' -f $SytemRoleId, $ItSystemId), 'Delete')) {
            
            try {
                Invoke-ApiClient -Uri $ApiUrl -Method 'DELETE'
                
                return $true
            } catch {
                return $false
            }
        }
    }
}