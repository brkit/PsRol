# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Get-RolAuditLog {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType([PsRolAuditLog])]
    param (
        [Parameter(ParameterSetName = 'Latest')]
        [int]$Latest,

        [Parameter(ParameterSetName = 'Default')]
        [int]$Offset = 0,

        [Parameter(ParameterSetName = 'Default')]
        [int]$Size = 250
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'Latest') {
            $HeadResponse = Invoke-ApiClient -Uri '/api/v2/auditlog/head' -Method 'GET'
            $HeadIndex = $HeadResponse.head ?? 0

            $ComputedOffset = $HeadIndex - (4 * $Latest)
            $ComputedSize = 4 * $Latest
            $ApiUrl = '/api/v2/auditlog/read?offset={0}&size={1}' -f $ComputedOffset, $ComputedSize
        }
        else {
            $ApiUrl = '/api/v2/auditlog/read?offset={0}&size={1}' -f $Offset, $Size
        }

        $Response = Invoke-ApiClient -Uri $ApiUrl -Method 'GET'

        $AuditLogs = foreach ($item in $Response) {
            [PsRolAuditLog]::new($item)
        }

        return $AuditLogs
    }
}
