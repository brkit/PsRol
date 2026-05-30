# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolConstraintValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ConstraintTypeId')]
        [string]$ConstraintTypeId,
        [Parameter(Mandatory = $true, ParameterSetName = 'ConstraintTypeEntityId')]
        [string]$ConstraintTypeEntityId,
        [Parameter(Mandatory = $true, ParameterSetName = 'ConstraintTypeEntityId')]
        [Parameter(Mandatory = $true, ParameterSetName = 'ConstraintTypeId')]
        [string]$ConstraintValue
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ConstraintTypeId') {
            $ApiUrlPart = "/api/v2/constraint/$ConstraintTypeId"
            $ConstraintType = Invoke-ApiClient -Uri $ApiUrlPart -Method GET
        }
        else {
            $ApiUrlPart = '/api/v2/constraint'
            $ConstraintTypes = Invoke-ApiClient -Uri $ApiUrlPart -Method GET
            $ConstraintType = $ConstraintTypes | Where-Object { $PSItem.entityId -eq $ConstraintTypeEntityId } | Select-Object -First 1
        }

        if ($null -eq $ConstraintType) {
            throw "Constraint type not found."
        }

        if (-not [string]::IsNullOrWhiteSpace($ConstraintType.regex)) {
            if ($ConstraintValue -notmatch $ConstraintType.regex) {
                throw "ConstraintValue '$ConstraintValue' does not match the required format: $($ConstraintType.regex)"
            }
        }

        $entityId = $ConstraintTypeEntityId
        if ([string]::IsNullOrEmpty($entityId)) {
            $entityId = $ConstraintType.entityId
        }

        return [PsRolConstraintValue]@{
            ConstraintTypeId       = $ConstraintType.id
            ConstraintTypeEntityId = $entityId
            ConstraintValue        = $ConstraintValue
            ConstraintValueType    = 'VALUE'
            ConstraintIdentifier   = $null
            Postponed              = $false
        }
    }
}
