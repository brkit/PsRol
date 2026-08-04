# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolOrgUnitUserRoleAssignment {
    [CmdletBinding(DefaultParameterSetName = 'ByUuid')]
    [OutputType([PsRolOrgUnitUserRoleAssignment])]
    param (
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'ByUuid', ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('Uuid', 'Id', 'OrgUnit')]
        [string]$OrgUnitUuid,

        [Parameter(Mandatory, Position = 0, ParameterSetName = 'ByName', ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [string]$OrgUnitName
    )

    process {
        $UuidsToFetch = @()

        if ($PSCmdlet.ParameterSetName -eq 'ByName' -or (-not [string]::IsNullOrWhiteSpace($OrgUnitName))) {
            $ResolvedOrgUnits = Get-RolOrganisation -Name $OrgUnitName
            if ($ResolvedOrgUnits) {
                $UuidsToFetch = $ResolvedOrgUnits.Uuid
            }
        }
        else {
            $parsedGuid = [guid]::Empty
            if ([guid]::TryParse($OrgUnitUuid, [ref]$parsedGuid)) {
                $UuidsToFetch = @($parsedGuid.ToString())
            }
            else {
                $ResolvedOrgUnits = Get-RolOrganisation -Name $OrgUnitUuid
                if ($ResolvedOrgUnits) {
                    $UuidsToFetch = $ResolvedOrgUnits.Uuid
                }
            }
        }

        foreach ($uuid in $UuidsToFetch) {
            if ([string]::IsNullOrWhiteSpace($uuid)) { continue }
            $ApiUrl = '/api/v2/organisation/{0}/assignment/userrole' -f [Uri]::EscapeDataString($uuid)
            $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'
            $ReturnObjects = foreach ($item in $Response) {
                [PsRolOrgUnitUserRoleAssignment]::new($item)
            }
            if ($ReturnObjects) {
                Set-DefaultDisplayPropertySet -InputObject $ReturnObjects -Properties 'AssignmentId', 'OrgUnit', 'UserRole', 'Inherit'
                $ReturnObjects
            }
        }
    }
}
