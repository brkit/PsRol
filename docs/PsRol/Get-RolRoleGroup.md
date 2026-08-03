---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolRoleGroup
---

# Get-RolRoleGroup

## SYNOPSIS

Retrieves user role groups from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolRoleGroup [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolRoleGroup` cmdlet issues a `GET` request to `/api/v2/rolegroup` and returns a list of `PsRolRoleGroup` objects representing defined user role groups.

## EXAMPLES

### Example 1: Retrieve all user role groups

```
PS C:\> Get-RolRoleGroup
```

Retrieves all user role groups from OS2rollekatalog.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### PsRolRoleGroup

Returns one or more `PsRolRoleGroup` objects.

## NOTES

## RELATED LINKS

