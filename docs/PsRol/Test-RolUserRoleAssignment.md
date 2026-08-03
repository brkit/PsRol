---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Test-RolUserRoleAssignment
---

# Test-RolUserRoleAssignment

## SYNOPSIS

Tests whether a user is assigned a specific user role in OS2rollekatalog.

## SYNTAX

### ByProperties (Default)

```
Test-RolUserRoleAssignment -UserId <string> [-Domain <string>] [-UserRoleId <string>]
 [-UserRoleName <string>] [-UserRoleIdentifier <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Test-RolUserRoleAssignment` cmdlet checks if a designated user (`-UserId`) has a specific user role assigned.

It fetches active role assignments via `GET /api/v2/user/{UserId}/assignments?domain={Domain}` and evaluates if any assigned role matches by `-UserRoleId` (aliased as `-Id`), wildcard pattern `-UserRoleName` (aliased as `-Name`), or exact technical `-UserRoleIdentifier` (aliased as `-Identifier`).

Returns `$true` if a matching role assignment is found; otherwise `$false`.

Accepts pipeline input by property name for parameters `UserId`, `UserRoleId`, `UserRoleName`, and `UserRoleIdentifier`.

## EXAMPLES

### Example 1: Test role assignment by user role ID

```
PS C:\> Test-RolUserRoleAssignment -UserId 'user123' -UserRoleId '1001'
```

Returns `$true` if user `user123` has user role `1001` assigned.

### Example 2: Test role assignment by role name pattern

```
PS C:\> Test-RolUserRoleAssignment -UserId 'user123' -UserRoleName '*Standard User*'
```

Returns `$true` if the user has any assigned user role matching '*Standard User*'.

### Example 3: Test role assignment in a custom domain

```
PS C:\> Test-RolUserRoleAssignment -UserId 'user123' -UserRoleIdentifier 'id-00000000-0000-0000-0000-000000000000' -Domain 'Skole'
```

Tests for role assignment within the `Skole` domain.

## PARAMETERS

### -Domain

Specifies the domain scope for testing role assignments. Defaults to `'Administrativt'`.

```yaml
Type: System.String
DefaultValue: Administrativt
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

### -UserId

Mandatory. Specifies the user identifier string. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserRoleId

Specifies the user role ID to test for. Aliased as `-Id`. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases:
- Id
ParameterSets:
- Name: ByProperties
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserRoleIdentifier

Specifies the exact technical string identifier of the user role to test. Aliased as `-Identifier`. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases:
- Identifier
ParameterSets:
- Name: ByProperties
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserRoleName

Specifies a wildcard pattern string to match against assigned user role names. Aliased as `-Name`. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: true
Aliases:
- Name
ParameterSets:
- Name: ByProperties
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

Accepts an object containing `UserId`, `UserRoleId`, `UserRoleName`, or `UserRoleIdentifier` properties via the pipeline.

## OUTPUTS

### System.Boolean

Returns `$true` if a matching role assignment exists; otherwise `$false`.

## NOTES

## RELATED LINKS

