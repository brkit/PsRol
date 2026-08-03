---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolTitle
---

# Get-RolTitle

## SYNOPSIS

Retrieves job titles registered in OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolTitle [[-Name] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolTitle` cmdlet fetches job titles from `/api/title`.

If `-Name` is supplied, returned titles are filtered using a wildcard search (`-like`). Returns strongly-typed `PsRolTitle` objects.

## EXAMPLES

### Example 1: Retrieve all titles

```
PS C:\> Get-RolTitle
```

Retrieves all job titles.

### Example 2: Filter job titles by name wildcard

```
PS C:\> Get-RolTitle -Name '*tekniker*'
```

Returns titles containing 'tekniker'.

## PARAMETERS

### -Name

Optional positional parameter. Specifies a wildcard pattern to filter job titles by name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: true
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

### PsRolTitle

Returns one or more `PsRolTitle` objects.

## NOTES

## RELATED LINKS

