---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Remove-RolUserRole
---

# Remove-RolUserRole

## SYNOPSIS

Deletes a user role from OS2rollekatalog via the REST API.

## SYNTAX

### __AllParameterSets

```
Remove-RolUserRole [[-UserRoleId] <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Remove-RolUserRole` cmdlet removes a user role identified by `-UserRoleId` from OS2rollekatalog.

Before performing deletion, it fetches the existing user role via `GET /api/v2/userrole/{UserRoleId}`. If found, it issues a `DELETE` request to `/api/v2/userrole/{UserRoleId}`.

Because deletion is a destructive operation (`ConfirmImpact = 'High'`),  will prompt for confirmation unless `-Confirm:$false` is specified.

Accepts `-UserRoleId` from the pipeline by property name.

Supports `-WhatIf` and `-Confirm` via `SupportsShouldProcess`.

## EXAMPLES

### Example 1: Remove a user role by ID

```
PS C:\> Remove-RolUserRole -UserRoleId '100' -Confirm:$false
```

Deletes user role `100` without prompting for confirmation.

### Example 2: Remove a user role using pipeline input

```
PS C:\> Get-RolUserRole -Name 'Obsolete Role' | Remove-RolUserRole
```

Pipes user role objects into `Remove-RolUserRole` to delete matching roles.

### Example 3: Test role deletion using WhatIf

```
PS C:\> Remove-RolUserRole -UserRoleId '300' -WhatIf
```

Demonstrates what user role would be deleted without deleting the user role.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet. Defaults to prompt because `ConfirmImpact` is `High`.

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

### -UserRoleId

Optional positional parameter. Specifies the unique ID of the user role to delete. Accepts pipeline input by property name.

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

### System.String

Accepts objects containing a `UserRoleId` property via the pipeline.

## OUTPUTS

### None

This cmdlet does not return output upon successful deletion.

## NOTES

## RELATED LINKS

