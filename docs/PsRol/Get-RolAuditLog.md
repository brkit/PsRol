---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolAuditLog
---

# Get-RolAuditLog

## SYNOPSIS

Retrieves audit log entries from OS2rollekatalog via the REST API.

## SYNTAX

### Default (Default)

```
Get-RolAuditLog [-Offset <int>] [-Size <int>] [<CommonParameters>]
```

### Latest

```
Get-RolAuditLog [-Latest <int>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolAuditLog` cmdlet retrieves audit log records from OS2rollekatalog.

When using the `Default` parameter set, you can page through audit log entries using `-Offset` (defaulting to `0`) and `-Size` (defaulting to `250`). This sends a `GET` request to `/api/v2/auditlog/read?offset={Offset}&size={Size}`.

When using the `Latest` parameter set with `-Latest <N>`, the cmdlet first fetches the current audit log head position from `/api/v2/auditlog/head` and dynamically calculates the offset and size parameters to return the most recent audit records.

Returns strongly-typed `PsRolAuditLog` objects.

## EXAMPLES

### Example 1: Retrieve audit log entries with default pagination

```powershell
PS C:\> Get-RolAuditLog
```

Retrieves the first 250 audit log entries starting from offset 0.

### Example 2: Retrieve audit log entries with custom offset and size

```powershell
PS C:\> Get-RolAuditLog -Offset 100 -Size 50
```

Retrieves 50 audit log records starting at offset 100.

### Example 3: Retrieve the latest audit log entries

```powershell
PS C:\> Get-RolAuditLog -Latest 5
```

Queries the audit log head index and retrieves the latest audit log events.

## PARAMETERS

### -Latest

Specifies the number of recent audit log entries to return. Cannot be combined with `-Offset` or `-Size`.

```yaml
Type: System.Int32
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Latest
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Offset

Specifies the zero-based starting offset for pagination. Defaults to `0`.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Default
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Size

Specifies the maximum number of log records to return in a single request. Defaults to `250`.

```yaml
Type: System.Int32
DefaultValue: 250
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: Default
  Position: Named
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

This cmdlet does not accept input from the pipeline.

## OUTPUTS

### PsRolAuditLog

Returns one or more `PsRolAuditLog` objects.

## NOTES

## RELATED LINKS

