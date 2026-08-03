---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: New-RolSystemRoleAssignment
---

# New-RolSystemRoleAssignment

## SYNOPSIS

Creates a system role assignment object for defining user roles.

## SYNTAX

### __AllParameterSets

```
New-RolSystemRoleAssignment [-SystemRoleId] <string> [[-ConstraintValues] <PsRolConstraintValue[]>]
 [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `New-RolSystemRoleAssignment` cmdlet constructs a `PsRolSystemRoleAssignment` object. This object couples a target system role (`-SystemRoleId`) with zero or more constraint value definitions (`-ConstraintValues`), and is passed when creating new user roles using `New-RolUserRole`.

## EXAMPLES

### Example 1: Create a system role assignment without constraints

```
PS C:\> New-RolSystemRoleAssignment -SystemRoleId 'sr100'
```

Creates a system role assignment object for system role `sr100`.

### Example 2: Create a system role assignment with constraint values

```
PS C:\> $constraint = New-RolConstraintValue -ConstraintTypeId '100' -ConstraintValue '1234'
PS C:\> New-RolSystemRoleAssignment -SystemRoleId '200' -ConstraintValues $constraint
```

Creates a system role assignment for system role `200` with attached constraint values.

## PARAMETERS

### -ConstraintValues

Specifies an array of `PsRolConstraintValue` objects created via `New-RolConstraintValue`.

```yaml
Type: PsRolConstraintValue[]
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SystemRoleId

Mandatory. Specifies the ID of the system role to assign.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### PsRolSystemRoleAssignment

Returns a `PsRolSystemRoleAssignment` object.

## NOTES

## RELATED LINKS

