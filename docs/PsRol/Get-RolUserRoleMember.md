---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolUserRoleMember
---

# Get-RolUserRoleMember

## SYNOPSIS

Retrieves users assigned to a specific user role in OS2rollekatalog.

## SYNTAX

### __AllParameterSets

```
Get-RolUserRoleMember [[-UserRoleId] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolUserRoleMember` cmdlet calls `GET /api/v2/userrole/{UserRoleId}/users` to fetch all users who are assigned the specified user role.

Returns strongly-typed `PsRolUserRoleMember` objects.

## EXAMPLES

### Example 1: Retrieve assigned users for a user role

```powershell
PS C:\> Get-RolUserRoleMember -UserRoleId 'ur101'
```

Retrieves user assignment members for user role `ur101`.

## PARAMETERS

### -UserRoleId

Optional positional parameter. Specifies the ID of the user role whose members should be retrieved.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
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

### PsRolUserRoleMember

Returns one or more `PsRolUserRoleMember` objects.

## NOTES

## RELATED LINKS

