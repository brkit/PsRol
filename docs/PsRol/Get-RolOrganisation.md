---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolOrganisation
---

# Get-RolOrganisation

## SYNOPSIS

Retrieves organizational units from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolOrganisation [[-Name] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolOrganisation` cmdlet retrieves organizational unit definitions from `/api/organisation/v3`.

If `-Name` is supplied, returned units are filtered using a regex match (`-match`) against the organizational unit name.

Accepts pipeline input by property name for `-Name`. Returns `PsRolOrganisation` objects.

## EXAMPLES

### Example 1: Get all organizational units

```
PS C:\> Get-RolOrganisation
```

Retrieves all organizational units.

### Example 2: Filter organizational units by name

```
PS C:\> Get-RolOrganisation -Name 'IT'
```

Filters organizational units matching the name pattern 'IT'.

### Example 3: Filter using pipeline input

```
PS C:\> [PSCustomObject]@{ Name = 'Økonomi' } | Get-RolOrganisation
```

Pipes an object with a `Name` property to filter organizational units.

## PARAMETERS

### -Name

Optional positional parameter. Specifies a regex pattern to filter organizational units by name. Accepts pipeline input by property name.

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

Accepts an object containing a `Name` property via the pipeline.

## OUTPUTS

### PsRolOrganisation

Returns one or more `PsRolOrganisation` objects.

## NOTES

## RELATED LINKS

