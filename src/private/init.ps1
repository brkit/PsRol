# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL

$Script:CacheTimeoutSeconds = 30

# Centralised argument completer for Domain parameter
# By convention domain is either "Administrativt" or "Skole", but is not strictly bound to these values.
# Using Register-ArgumentCompleter ensures tab-completion without strict validation, so other values can be specified manually.
Register-ArgumentCompleter -CommandName Add-RolAssignUserRole, Get-RolUserRoleAssignment, New-RolItSystem, Test-RolUserRoleAssignment -ParameterName Domain -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    @('Administrativt', 'Skole').Where({ $PSItem -like ('{0}*' -f $wordToComplete) }) |
    ForEach-Object { [System.Management.Automation.CompletionResult]::new($PSItem, $PSItem, 'ParameterValue', $PSItem) }
}
