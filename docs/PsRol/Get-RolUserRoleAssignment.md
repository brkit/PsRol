---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolUserRoleAssignment
---

# Get-RolUserRoleAssignment

## SYNOPSIS

Retrieves role assignments for a user in OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolUserRoleAssignment [-UserId] <string> [[-System] <string>] [[-Domain] <string>]
 [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolUserRoleAssignment` cmdlet fetches assigned user roles for a specified user (`-UserId`).

It issues a `GET` request to `/api/v2/user/{UserId}/assignments`. Optional query parameters `-System` and `-Domain` filter assignments by IT system or domain scope.

Accepts `-UserId` from the pipeline by value or property name. Returns strongly-typed `PsRolUserRoleAssignment` objects.

## EXAMPLES

### Example 1: Retrieve user role assignments for a user

```powershell
PS C:\> Get-RolUserRoleAssignment -UserId 'user01'
```

Retrieves all user role assignments for user `user01`.

### Example 2: Filter user role assignments by system and domain

```powershell
PS C:\> Get-RolUserRoleAssignment -UserId 'user01' -System 'sys01' -Domain 'Skole'
```

Retrieves user role assignments for `user01` within the `sys01` IT system and `Skole` domain.

### Example 3: Pipeline input by value or property name

```powershell
PS C:\> 'user01' | Get-RolUserRoleAssignment
```

Pipes user ID string directly to retrieve user role assignments.

## PARAMETERS

### -Domain

Specifies an optional domain filter string (e.g. `'Administrativt'` or `'Skole'`). If not specified defaults to `'Administrativt'`.

```yaml
Type: System.String
DefaultValue: None
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

### -System

Specifies an optional IT system identifier filter.

```yaml
Type: System.String
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

### -UserId

Mandatory. Specifies the user identifier string. Accepts pipeline input by value or by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: true
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

Accepts a user ID string or object containing a `UserId` property via the pipeline.

## OUTPUTS

### PsRolUserRoleAssignment

Returns one or more `PsRolUserRoleAssignment` objects.

## NOTES

## RELATED LINKS

