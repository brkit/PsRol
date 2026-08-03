---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolItSystem
---

# Get-RolItSystem

## SYNOPSIS

Retrieves IT systems registered in OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Get-RolItSystem [[-ItSystemId] <string>] [[-Name] <string>] [[-Identifier] <string>] [-All]
 [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolItSystem` cmdlet fetches IT system entries from OS2rollekatalog.

If `-ItSystemId` is provided, it queries `GET /api/v2/itsystem/{ItSystemId}` directly without using or updating the list cache. Otherwise, it calls `GET /api/v2/itsystem` and caches the result for subsequent calls within the session to reduce API requests.

By default, only IT systems with `canEditThroughApi` set to `$true` are returned. Specify `-All` to return all IT systems regardless of API editability.

Filtering parameters `-Name` and `-Identifier` apply regex matching against system names and technical identifiers respectively.

Returns strongly-typed `PsRolItSystem` objects.

## EXAMPLES

### Example 1: Retrieve API-editable IT systems

```
PS C:\> Get-RolItSystem
```

Returns all IT systems that can be edited through the API (cached for subsequent calls).

### Example 2: Retrieve all IT systems including non-editable systems

```
PS C:\> Get-RolItSystem -All
```

Returns all registered IT systems.

### Example 3: Get a specific IT system by ID

```
PS C:\> Get-RolItSystem -ItSystemId 'system1'
```

Queries `GET /api/v2/itsystem/system1` directly without using or updating the list cache and returns the matching system.

### Example 4: Filter IT systems by name or identifier

```
PS C:\> Get-RolItSystem -All -Name 'Active Directory' -Identifier 'AD01'
```

Filters IT systems matching name 'Active Directory' and identifier 'AD01'.

## PARAMETERS

### -All

Switch parameter. When specified, returns all IT systems, including those where `canEditThroughApi` is false.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
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

### -Identifier

Specifies the string to match against the IT system technical identifier.

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

### -ItSystemId

Specifies the unique ID of a specific IT system to fetch directly from the API without using or updating the list cache.

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

### -Name

Specifies the string to match against the IT system display name.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### PsRolItSystem

Returns one or more `PsRolItSystem` objects.

## NOTES

## RELATED LINKS

