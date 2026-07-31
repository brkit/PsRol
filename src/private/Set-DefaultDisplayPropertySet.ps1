# Copyright (c) Bornholms Regionskommune. Licensed under the EUPL
function Set-DefaultDisplayPropertySet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification='Cmdlet does not modify system state')]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$InputObject,

        [Parameter(Mandatory)]
        [string[]]$Properties
    )

    process {
        if ($InputObject) {
            $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]$Properties)
            $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)
            $InputObject | Add-Member MemberSet PSStandardMembers $PSStandardMembers
        }
    }
}
