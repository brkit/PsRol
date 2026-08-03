---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolFunction
---

# Get-RolFunction

## SYNOPSIS

Retrieves functions from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolFunction [[-Name] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolFunction` cmdlet fetches functions defined in OS2rollekatalog by issuing a `GET` request to `/api/v2/function`.

If `-Name` is specified, the results are filtered using wildcard matching (`-like`). If `-Name` is omitted or empty, all functions are returned as strongly-typed `PsRolFunction` objects.

## EXAMPLES

### Example 1: Retrieve all functions

```
PS C:\> Get-RolFunction
```

Retrieves all function definitions from OS2rollekatalog.

### Example 2: Filter functions by name wildcard pattern

```
PS C:\> Get-RolFunction -Name '*Sikkerhed*'
```

Retrieves functions whose name contains 'Sikkerhed'.

## PARAMETERS

### -Name

Optional positional parameter. Specifies a wildcard pattern string to filter returned functions by name.

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

### PsRolFunction

Returns one or more `PsRolFunction` objects.

## NOTES

## RELATED LINKS

