# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolRoleAssignmentScope {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PsRolAssignmentScopeType]$Type,
        [PsRolTitle[]]$Title
    )
    
    process {
        
        #TODO: Maybe support other scopes
        switch($Type) {
            ([PsRolAssignmentScopeType]::TITLE) {
                [PsRolAssignmentScope]::new($Type, $Title)
            }
            default {
                Write-Warning -Message $('Assignment Scope: ''{0}'' not yet implemented' -f $Type.toString())
                return;
            }
        }
    }

}