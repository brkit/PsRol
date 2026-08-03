---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Get-RolConfiguration
---

# Get-RolConfiguration

## SYNOPSIS

Gets the current in-memory or persisted session configuration for the PsRol module.

## SYNTAX

### __AllParameterSets

```
Get-RolConfiguration [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Get-RolConfiguration` cmdlet returns the active configuration settings (such as `BaseUrl` and `ApiKey`) stored in module script scope.

If no configuration is currently loaded in memory, it attempts to load settings from `~/.PsRolConfig.json`. If the file does not exist, an empty hashtable is returned.

## EXAMPLES

### Example 1: Retrieve the current module configuration

```
PS C:\> Get-RolConfiguration
```

Returns the current session configuration containing keys `BaseUrl` and `ApiKey`.

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

### System.Collections.Hashtable

Returns the current configuration.

## NOTES

## RELATED LINKS

