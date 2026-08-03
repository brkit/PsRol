---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: New-RolUserRole
---

# New-RolUserRole

## SYNOPSIS

Creates a new user role in OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
New-RolUserRole [-Name] <string> [-Description] <string> [-ItSystemId] <string>
 [-SystemRoleAssignment] <PsRolSystemRoleAssignment[]> [-SensitiveRole] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `New-RolUserRole` cmdlet creates a new user role definition in OS2rollekatalog by posting a payload to `/api/v2/userrole`.

Parameters require display name (`-Name`), description (`-Description`), target IT system ID (`-ItSystemId`), and an array of system role assignments (`-SystemRoleAssignment`). Optional flag `-SensitiveRole` marks the role as sensitive.

Accepts pipeline input by property name for `-ItSystemId` and `-SystemRoleAssignment`.

Supports `-WhatIf` and `-Confirm` via `SupportsShouldProcess`.

## EXAMPLES

### Example 1: Create a user role with system role assignments

```powershell
PS C:\> $sra = New-RolSystemRoleAssignment -SystemRoleId '120'
PS C:\> New-RolUserRole -Name 'Test User Role' -Description 'Description' -ItSystemId '100' -SystemRoleAssignment $sra -SensitiveRole
```

Creates a new user role named 'Test User Role' associated with IT system `100` and system role `120`.

### Example 2: Create a user role using pipeline input

```powershell
PS C:\> $sra = New-RolSystemRoleAssignment -SystemRoleId '210'
PS C:\> [PSCustomObject]@{ ItSystemId = '200'; SystemRoleAssignment = @($sra) } | New-RolUserRole -Name 'Pipeline Role' -Description 'Role via pipeline'
```

Pipes IT system ID and system role assignments to create a user role.

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

### -Description

Mandatory. Specifies the description text for the user role. Empty strings are permitted.

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

### -ItSystemId

Mandatory. Specifies the ID of the IT system to which this user role belongs. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

Mandatory. Specifies the display name of the user role.

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

### -SensitiveRole

Switch parameter. When specified, marks the user role as a sensitive role.

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

### -SystemRoleAssignment

Mandatory. Specifies one or more `PsRolSystemRoleAssignment` objects to include in the user role. Accepts pipeline input by property name.

```yaml
Type: PsRolSystemRoleAssignment[]
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

### System.String

Accepts objects containing `ItSystemId` and `SystemRoleAssignment` properties via the pipeline.

### PsRolSystemRoleAssignment[]

Accepts objects of type PsRolSystemRoleAssignment via the pipeline

## OUTPUTS

### System.Management.Automation.PSCustomObject

Returns the created user role object response from the API.

## NOTES

## RELATED LINKS
