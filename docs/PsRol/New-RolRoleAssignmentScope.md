---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: New-RolRoleAssignmentScope
---

# New-RolRoleAssignmentScope

## SYNOPSIS

Creates a role assignment scope object for defining assignment conditions.

## SYNTAX

### __AllParameterSets

```
New-RolRoleAssignmentScope [-Type] <PsRolAssignmentScopeType> [[-Title] <PsRolTitle[]>]
 [[-Functions] <PsRolFunction[]>] [[-ExcludedTitles] <PsRolTitle[]>]
 [[-ExceptedUsers] <PsRolUser[]>] [-Manager] [-Substitute] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `New-RolRoleAssignmentScope` cmdlet constructs a `PsRolAssignmentScope` object used when assigning role groups or user roles to organizational units.

Depending on the `-Type` parameter (`TITLE`, `MANAGER`, `FUNCTION`, `EXCLUDED_TITLE`, `EXCEPTED_USER`), the appropriate parameters must be supplied:
- `TITLE`: Requires `-Title`
- `MANAGER`: Accepts `-Manager` and `-Substitute` switches
- `FUNCTION`: Requires `-Functions`
- `EXCLUDED_TITLE`: Requires `-ExcludedTitles`
- `EXCEPTED_USER`: Requires `-ExceptedUsers`

## EXAMPLES

### Example 1: Create a TITLE scope

```
PS C:\> $title = Get-RolTitle -Name 'Teacher'
PS C:\> New-RolRoleAssignmentScope -Type TITLE -Title $title
```

Constructs an assignment scope targeting users with the 'Teacher' title.

### Example 2: Create a MANAGER scope with substitute support

```
PS C:\> New-RolRoleAssignmentScope -Type MANAGER -Manager -Substitute
```

Constructs a manager assignment scope that also applies to manager substitutes.

### Example 3: Create an EXCLUDED_TITLE scope

```
PS C:\> $excluded = Get-RolTitle -Name 'Consultant'
PS C:\> New-RolRoleAssignmentScope -Type EXCLUDED_TITLE -ExcludedTitles $excluded
```

Constructs a scope excluding users with the 'Consultant' title.

## PARAMETERS

### -ExceptedUsers

Specifies an array of `PsRolUser` objects to except from the scope when `-Type` is `EXCEPTED_USER`.

```yaml
Type: PsRolUser[]
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

### -ExcludedTitles

Specifies an array of `PsRolTitle` objects to exclude from the scope when `-Type` is `EXCLUDED_TITLE`.

```yaml
Type: PsRolTitle[]
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

### -Functions

Specifies an array of `PsRolFunction` objects when `-Type` is `FUNCTION`. Aliased as `Function`.

```yaml
Type: PsRolFunction[]
DefaultValue: None
SupportsWildcards: false
Aliases:
- Function
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

### -Manager

Switch parameter. When specified for `-Type MANAGER`, includes managers in the scope.

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

### -Substitute

Switch parameter. When specified for `-Type MANAGER`, includes manager substitutes in the scope.

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

### -Title

Specifies an array of `PsRolTitle` objects when `-Type` is `TITLE`. Aliased as `Titles`.

```yaml
Type: PsRolTitle[]
DefaultValue: None
SupportsWildcards: false
Aliases:
- Titles
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

### -Type

Mandatory. Specifies the scope type enum (`TITLE`, `MANAGER`, `FUNCTION`, `EXCLUDED_TITLE`, `EXCEPTED_USER`).

```yaml
Type: PsRolAssignmentScopeType
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
AcceptedValues:
- TITLE
- MANAGER
- FUNCTION
- EXCLUDED_TITLE
- EXCEPTED_USER
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

### PsRolAssignmentScope

Returns a `PsRolAssignmentScope` object.

## NOTES

## RELATED LINKS

