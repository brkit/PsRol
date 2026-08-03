---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: New-RolConstraintValue
---

# New-RolConstraintValue

## SYNOPSIS

Creates a constraint value object used when creating system role assignments.

## SYNTAX

### ConstraintTypeId

```
New-RolConstraintValue -ConstraintTypeId <string> -ConstraintValue <string> [<CommonParameters>]
```

### ConstraintTypeEntityId

```
New-RolConstraintValue -ConstraintTypeEntityId <string> -ConstraintValue <string>
 [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `New-RolConstraintValue` cmdlet constructs a `PsRolConstraintValue` object for configuring constraint values on system role assignments.

It queries the `/api/v2/constraint` endpoints to retrieve constraint type definitions and validates the provided `-ConstraintValue` against any regex pattern defined on the backend constraint type. If validation fails or the constraint type is not found, an error is thrown.

## EXAMPLES

### Example 1: Create a constraint value using ConstraintTypeId

```
PS C:\> New-RolConstraintValue -ConstraintTypeId '100' -ConstraintValue '1234'
```

Retrieves constraint metadata for `100`, validates `1234` against its regex filter, and returns a `PsRolConstraintValue` object.

### Example 2: Create a constraint value using ConstraintTypeEntityId

```
PS C:\> New-RolConstraintValue -ConstraintTypeEntityId 'http://sts.kombit.dk/constraints/orgenhed/1' -ConstraintValue '00000000-0000-0000-0000-000000000000'
```

Looks up constraint type by entity ID 'http://sts.kombit.dk/constraints/orgenhed/1' and constructs the constraint value object.

## PARAMETERS

### -ConstraintTypeEntityId

Mandatory in `ConstraintTypeEntityId` parameter set. Specifies the entity ID string of the target constraint type.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ConstraintTypeEntityId
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConstraintTypeId

Mandatory in `ConstraintTypeId` parameter set. Specifies the unique ID of the target constraint type.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ConstraintTypeId
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ConstraintValue

Mandatory in all parameter sets. Specifies the value string to apply to the constraint. Must pass the constraint type's regex validation.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ConstraintTypeId
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
- Name: ConstraintTypeEntityId
  Position: Named
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

### PsRolConstraintValue

Returns a `PsRolConstraintValue` object.

## NOTES

## RELATED LINKS

