---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Add-RolOrgUnitAssignRoleGroup
---

# Add-RolOrgUnitAssignRoleGroup

## SYNOPSIS

Assigns a role group to an organizational unit in OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Add-RolOrgUnitAssignRoleGroup [-RoleGroupId] <string> [-OrgUnitUuid] <string>
 [[-StartDate] <datetime>] [[-StopDate] <datetime>] [[-Scope] <PsRolAssignmentScope[]>] [-Inherit]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Add-RolOrgUnitAssignRoleGroup` cmdlet assigns a user role group (`-RoleGroupId`) to a specified organizational unit (`-OrgUnitUuid`). It posts a JSON payload to `/api/v2/organisation/assignment/rolegroup`.

Parameters allow setting the start date (`-StartDate`, defaulting to the current date), optional end date (`-StopDate`), scope restriction objects (`-Scope`), and whether descendant organizational units inherit the assignment (`-Inherit`).

The cmdlet supports `-WhatIf` and `-Confirm` via `SupportsShouldProcess`.

## EXAMPLES

### Example 1: Assign a role group to an organizational unit with inheritance

```powershell
PS C:\> Add-RolOrgUnitAssignRoleGroup -RoleGroupId '100' -OrgUnitUuid '00000000-0000-0000-0000-000000000001' -Inherit
```

Assigns role group `100` to organizational unit `00000000-0000-0000-0000-000000000001`, enabling inheritance to descendant organizational units.

### Example 2: Assign a role group with scope restrictions and expiration

```powershell
PS C:\> $scope = New-RolRoleAssignmentScope -Type MANAGER -Manager
PS C:\> $stop = (Get-Date).AddMonths(6)
PS C:\> Add-RolOrgUnitAssignRoleGroup -RoleGroupId '200' -OrgUnitUuid '00000000-0000-0000-0000-000000000002' -StopDate $stop -Scope $scope
```

Assigns role group `200` to the specified organizational unit with a manager scope constraint, valid for 6 months.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- cf
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Inherit

Switch parameter. When specified, descendant organizational units inherit this role group assignment.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -OrgUnitUuid

Mandatory. Specifies the UUID of the target organizational unit.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -RoleGroupId

Mandatory. Specifies the ID of the role group to assign.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Scope

Specifies one or more `PsRolAssignmentScope` objects defining additional criteria for the assignment.

```yaml
Type: PsRolAssignmentScope[]
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -StartDate

Specifies the effective start date for the assignment. Defaults to current date/time.

```yaml
Type: System.DateTime
DefaultValue: (Get-Date)
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -StopDate

Specifies an optional expiration date for the assignment.

```yaml
Type: System.DateTime
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- wi
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### None

This cmdlet does not produce any output.

## NOTES

## RELATED LINKS

