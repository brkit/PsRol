# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function New-RolRoleAssignmentScope {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification='Cmdlet does not modify system state')]
    [CmdletBinding()]
    [OutputType([PsRolAssignmentScope])]
    param (
        [Parameter(Mandatory)]
        [PsRolAssignmentScopeType]$Type,

        [Parameter(Mandatory = $false)]
        [Alias('Titles')]
        [PsRolTitle[]]$Title,

        [Parameter(Mandatory = $false)]
        [switch]$Manager,

        [Parameter(Mandatory = $false)]
        [switch]$Substitute,

        [Parameter(Mandatory = $false)]
        [Alias('Function')]
        [PsRolFunction[]]$Functions,

        [Parameter(Mandatory = $false)]
        [PsRolTitle[]]$ExcludedTitles,

        [Parameter(Mandatory = $false)]
        [PsRolUser[]]$ExceptedUsers
    )
    
    process {
        switch ($Type) {
            ([PsRolAssignmentScopeType]::TITLE) {
                if (-not $Title) {
                    throw "Parameter -Title is required for scope type TITLE."
                }
                return [PsRolAssignmentScope]@{
                    type   = $Type
                    titles = $Title
                }
            }
            ([PsRolAssignmentScopeType]::MANAGER) {
                return [PsRolAssignmentScope]@{
                    type       = $Type
                    manager    = $Manager.IsPresent
                    substitute = $Substitute.IsPresent
                }
            }
            # I have no idea how this works yet, but should be similar to titles I hope :D
            ([PsRolAssignmentScopeType]::FUNCTION) {
                if (-not $Functions) {
                    throw "Parameter -Functions is required for scope type FUNCTION."
                }
                return [PsRolAssignmentScope]@{
                    type      = $Type
                    functions = $Functions
                }
            }
            ([PsRolAssignmentScopeType]::EXCLUDED_TITLE) {
                if (-not $ExcludedTitles) {
                    throw "Parameter -ExcludedTitles is required for scope type EXCLUDED_TITLE."
                }
                return [PsRolAssignmentScope]@{
                    type           = $Type
                    excludedTitles = $ExcludedTitles
                }
            }
            # No idea about this one either, have only seen similar user objects in output from /api/v2/rolegroup/{roleGroupId}/users
            ([PsRolAssignmentScopeType]::EXCEPTED_USER) {
                if (-not $ExceptedUsers) {
                    throw "Parameter -ExceptedUsers is required for scope type EXCEPTED_USER."
                }
                return [PsRolAssignmentScope]@{
                    type          = $Type
                    exceptedUsers = $ExceptedUsers
                }
            }
            default {
                Write-Warning -Message $('Assignment Scope: ''{0}'' not yet implemented' -f $Type.toString())
                return
            }
        }
    }
}