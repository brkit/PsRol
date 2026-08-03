---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Set-RolConfiguration
---

# Set-RolConfiguration

## SYNOPSIS

Configures module settings including BaseUrl and ApiKey for REST API connection.

## SYNTAX

### __AllParameterSets

```
Set-RolConfiguration [-BaseUrl] <string> [-ApiKey] <string> [-AsDotFile] [-ApiKeyInDotFile]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Set-RolConfiguration` cmdlet sets the REST API endpoint URL (`-BaseUrl`) and API key credentials (`-ApiKey`) used by PsRol cmdlets.

`-BaseUrl` must be a valid HTTPS URL (HTTP is not supported and will throw an error).

By default, settings are stored in session memory. Specifying `-AsDotFile` saves configuration to `~/.PsRolConfig.json`. By default when `-AsDotFile` is used, the API key is omitted from disk unless `-ApiKeyInDotFile` is explicitly passed (which emits a warning about storing secrets in plaintext).

Supports `-WhatIf` and `-Confirm` via `SupportsShouldProcess`.

## EXAMPLES

### Example 1: Set in-memory session configuration

```
PS C:\> Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey 'my-secret-api-key'
```

Configures the base URL and API key for the current PowerShell session.

### Example 2: Save configuration to dotfile without persisting ApiKey

```
PS C:\> Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey 'my-secret-api-key' -AsDotFile
```

Saves the base URL to `~/.PsRolConfig.json` while excluding the API key.

### Example 3: Persist ApiKey to dotfile

```
PS C:\> Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey 'my-secret-api-key' -AsDotFile -ApiKeyInDotFile
```

Saves both base URL and API key to `~/.PsRolConfig.json` and emits a security warning.

## PARAMETERS

### -ApiKey

Mandatory. Specifies the API key string used for authenticating REST API requests.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ApiKeyInDotFile

Switch parameter. When specified with `-AsDotFile`, includes the plaintext API key in `~/.PsRolConfig.json`.

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

### -AsDotFile

Switch parameter. When specified, writes configuration to `~/.PsRolConfig.json`.

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

### -BaseUrl

Mandatory. Specifies the base HTTPS URL of the OS2rollekatalog API server.

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
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- cf
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

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- wi
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

## RELATED LINKS

