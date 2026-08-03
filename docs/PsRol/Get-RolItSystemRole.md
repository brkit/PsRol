---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolItSystemRole
---

# Get-RolItSystemRole

## SYNOPSIS

Retrieves system roles associated with an IT system from OS2rollekatalog.

## SYNTAX

### __AllParameterSets

```
Get-RolItSystemRole [-ItSystemId] <string> [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolItSystemRole` cmdlet retrieves system role definitions belonging to the specified IT system (`-ItSystemId`).

It calls `GET /api/v2/itsystem/{ItSystemId}/systemroles` and maps the JSON response objects into `PsRolSystemRole` instances.

The `-ItSystemId` parameter accepts input from the pipeline by property name.

## EXAMPLES

### Example 1: Get system roles for an IT system by ID

```
PS C:\> Get-RolItSystemRole -ItSystemId 'sys100'
```

Retrieves all system roles belonging to IT system `sys100`.

### Example 2: Retrieve system roles using pipeline input

```
PS C:\> Get-RolItSystem -Name 'AD System' | Get-RolItSystemRole
```

Pipes IT system objects into `Get-RolItSystemRole` to fetch system roles for each system.

## PARAMETERS

### -ItSystemId

Mandatory. Specifies the ID of the IT system. Accepts pipeline input by property name.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
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

Accepts an object with an `ItSystemId` property via the pipeline.

## OUTPUTS

### PsRolSystemRole

Returns one or more `PsRolSystemRole` objects.

## NOTES

## RELATED LINKS

