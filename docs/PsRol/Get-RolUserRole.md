---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolUserRole
---

# Get-RolUserRole

## SYNOPSIS

Retrieves user roles from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolUserRole [[-UserRoleId] <string>] [[-Name] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolUserRole` cmdlet fetches user role definitions by sending a `GET` request to `/api/v2/userrole`.

Results are cached within the session for 30 seconds on subsequent calls without a specific ID to minimize API requests. When `-UserRoleId` is specified, the cmdlet queries `/api/v2/userrole/{UserRoleId}` directly without using or populating the list cache.

If `-Name` is specified, the user roles are filtered using wildcard matching (`-like`).

Returns strongly-typed `PsRolUserRole` objects with default display properties `UserRoleId`, `Name`, and `Description`.

## EXAMPLES

### Example 1: Retrieve all user roles

```
PS C:\> Get-RolUserRole
```

Retrieves all user roles defined in OS2rollekatalog.

### Example 2: Filter user roles by name wildcard

```
PS C:\> Get-RolUserRole -Name '*Skole*'
```

Returns user roles matching the name pattern '*Skole*'.

### Example 3: Retrieve a specific user role by ID

```
PS C:\> Get-RolUserRole -UserRoleId 101
```

Retrieves the specific user role with ID 101 directly from the API.

## PARAMETERS

### -Name

Optional positional parameter. Specifies a wildcard string pattern to filter user roles by name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: true
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

### -UserRoleId

Specifies the unique identifier of a specific user role to retrieve directly from the API.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases:
- Id
ParameterSets:
- Name: (All)
  Position: 0
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

### PsRolUserRole

Returns one or more `PsRolUserRole` objects.

## NOTES

## RELATED LINKS

