---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolManager
---

# Get-RolManager

## SYNOPSIS

Retrieves manager records and their substitutes from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolManager [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolManager` cmdlet queries the OS2rollekatalog REST API at `/api/v2/manager` and returns a collection of `PsRolManager` objects representing organizational managers and their assigned manager substitutes.

## EXAMPLES

### Example 1: Retrieve all managers

```
PS C:\> Get-RolManager
```

Retrieves manager records and their substitute mappings.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept input from the pipeline.

## OUTPUTS

### PsRolManager

Returns one or more `PsRolManager` objects.

## NOTES

## RELATED LINKS

