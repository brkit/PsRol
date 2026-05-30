# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Add-RolAssignUserRole {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$UserRoleId,
        [Parameter(Mandatory = $true)]
        [String]$UserId,
        [Parameter(Mandatory = $false)]
        [DateTime]$StartDate = (Get-Date),
        [Parameter(Mandatory = $false)]
        [DateTime]$StopDate,
        
        # By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
        # Creating an argument completer instead of an enum ensures tab-completion between the two conventional values, but doesn't cause validation so other values can be specified manually.
        [Parameter(Mandatory = $true)]
        [ArgumentCompleter( {
                param ( $commandName,
                    $parameterName,
                    $wordToComplete,
                    $commandAst,
                    $fakeBoundParameters )
                $domains = @('Administrativt', 'Skole') | Where-Object { $PSItem -Like "$wordToComplete*" }
                $domains | ForEach-Object { New-Object -Type System.Management.Automation.CompletionResult -ArgumentList @(
                        $PSItem
                        $PSItem
                        'ParameterValue'
                        $PSItem
                    )
                }
            })]
        [String]$Domain = 'Administrativt'
    )
    
    process {
        $ApiUrl = '/api/v2/user/{0}/assign/userrole/{1}' -f $UserId, $UserRoleId

        $Request = [PSCustomObject]@{
            startDate            = $StartDate.ToString('yyyy-MM-dd')
            stopDate             = $StopDate ? $StopDate.ToString('yyyy-MM-dd') : ""
            domain               = $Domain
            onlyIfNotAssigned    = $false
            postponedConstraints = @()
        }

        Invoke-ApiClient -Uri $ApiUrl -Method 'PUT' -Body ($Request | ConvertTo-Json)
    }

}