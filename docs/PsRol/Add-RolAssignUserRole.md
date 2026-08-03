---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Add-RolAssignUserRole
---

# Add-RolAssignUserRole

## SYNOPSIS

Assigns a user role to a user in OS2rollekatalog via the REST API.

## SYNTAX

### ByUserRoleId (Default)

```
Add-RolAssignUserRole -UserRoleId <string> -UserId <Object> [-StartDate <datetime>]
 [-StopDate <datetime>] [-Domain <string>] [-AllowExtraAssignments] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ByName

```
Add-RolAssignUserRole -Name <string> -UserId <object> [-StartDate <datetime>] [-StopDate <datetime>]
 [-Domain <string>] [-AllowExtraAssignments] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Add-RolAssignUserRole` cmdlet assigns a user role specified by `-UserRoleId` or `-Name` to a target user identified by `-UserId`. It communicates with the OS2rollekatalog REST API via a `PUT` request to `/api/v2/user/{UserId}/assign/userrole/{UserRoleId}`.

When specifying `-Name`, the cmdlet resolves the user role ID using `Get-RolUserRole`. If multiple user roles exist with the specified name, the cmdlet throws an error prompting you to specify the `-UserRoleId` instead.

By default, the role assignment starts on the current date (`Get-Date`) and belongs to the `'Administrativt'` domain. You can specify a custom start date using `-StartDate`, an optional expiration date with `-StopDate`, or set a custom domain with `-Domain`.

Unless `-AllowExtraAssignments` is passed, duplicate role assignments are prevented.

The cmdlet supports `-WhatIf` and `-Confirm` via `SupportsShouldProcess`.

## EXAMPLES

### Example 1: Assign a user role with default parameters

```
PS C:\> Add-RolAssignUserRole -UserId 'user01' -UserRoleId '500'
```

Assigns user role `500` to user `user01` starting from today in the default `Administrativt` domain.

### Example 2: Assign a user role by name

```
PS C:\> Add-RolAssignUserRole -UserId 'user01' -Name 'OS2rollekatalog Administrator'
```

Resolves the user role ID for 'OS2rollekatalog Administrator' and assigns it to user `user01`.

### Example 3: Assign a user role with a stop date and custom domain

```
PS C:\> $start = Get-Date
PS C:\> $stop = $start.AddDays(30)
PS C:\> Add-RolAssignUserRole -UserId 'user02' -UserRoleId '600' -StartDate $start -StopDate $stop -Domain 'Skole' -AllowExtraAssignments
```

Assigns user role `600` to user `user02` for 30 days in the `Skole` domain, permitting extra duplicate assignments if already present.

### Example 4: Test role assignment using WhatIf

```
PS C:\> Add-RolAssignUserRole -UserId 'user01' -UserRoleId '100' -WhatIf
```

Demonstrates what action would be taken without submitting the role assignment to the backend API.

### Example 5: Assign a user role via pipeline using Get-ADUser

```
PS C:\> Get-ADUser -Identity 'user03' | Add-RolAssignUserRole -UserRoleId '500'
```

Pipes an `ADUser` object into `Add-RolAssignUserRole`, automatically extracting its `SamAccountName` property to assign user role `500`.

### Example 6: Assign a user role via pipeline using Get-ADGroupMember

```
PS C:\> Get-ADGroupMember -Identity 'FinanceUsers' | Add-RolAssignUserRole -UserRoleId '600'
```

Pipes `ADPrincipal` objects from an Active Directory group into `Add-RolAssignUserRole`. Verifies that each principal has `objectClass` set to `'user'` and extracts its `SamAccountName` to assign it user role with Id `600`.

Note that if the AD group `FinanceUsers` contains members that are not of type `user`, they are skipped.

## PARAMETERS

### -AllowExtraAssignments

Switch parameter. When specified, permits creating an additional assignment even if the user is already assigned the user role.
Switch parameter.
When specified, permits creating an additional assignment even if the user is already assigned the user role.
Switch parameter.
When specified, permits creating an additional assignment even if the user is already assigned the user role.
Switch parameter.
When specified, permits creating an additional assignment even if the user is already assigned the user role.

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

### -Domain

Specifies the domain scope for the role assignment. Defaults to `'Administrativt'`. Common values are `'Administrativt'` or `'Skole'`.
Specifies the domain scope for the role assignment.
Defaults to `'Administrativt'`.
Common values are `'Administrativt'` or `'Skole'`.
Specifies the domain scope for the role assignment.
Defaults to `'Administrativt'`.
Common values are `'Administrativt'` or `'Skole'`.
Specifies the domain scope for the role assignment.
Defaults to `'Administrativt'`.
Common values are `'Administrativt'` or `'Skole'`.

```yaml
Type: System.String
DefaultValue: Administrativt
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

### -Name

Specifies the name of the user role to assign. The cmdlet resolves the name to a unique user role ID via `Get-RolUserRole`. If multiple user roles share the same name, an error is raised asking to specify `-UserRoleId` instead.
Specifies the name of the user role to assign.
The cmdlet resolves the name to a unique user role ID via `Get-RolUserRole`.
If multiple user roles share the same name, an error is raised asking to specify `-UserRoleId` instead.
Specifies the name of the user role to assign.
The cmdlet resolves the name to a unique user role ID via `Get-RolUserRole`.
If multiple user roles share the same name, an error is raised asking to specify `-UserRoleId` instead.
Specifies the name of the user role to assign.
The cmdlet resolves the name to a unique user role ID via `Get-RolUserRole`.
If multiple user roles share the same name, an error is raised asking to specify `-UserRoleId` instead.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ByName
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -StartDate

Specifies the start date from which the role assignment becomes valid. Defaults to the current date and time.
Specifies the start date from which the role assignment becomes valid.
Defaults to the current date and time.
Specifies the start date from which the role assignment becomes valid.
Defaults to the current date and time.
Specifies the start date from which the role assignment becomes valid.
Defaults to the current date and time.

```yaml
Type: System.DateTime
DefaultValue: (Get-Date)
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

### -StopDate

Specifies the optional end date when the role assignment expires.

```yaml
Type: System.DateTime
DefaultValue: None
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

### -UserId

Mandatory. Specifies the unique identifier (UUID or username) of the target user, or an AD user/principal object via pipeline (`Microsoft.ActiveDirectory.Management.ADUser` or `Microsoft.ActiveDirectory.Management.ADPrincipal` with `objectClass` set to `'user'`).
Mandatory.
Specifies the unique identifier (UUID or username) of the target user, or an AD user/principal object via pipeline (`Microsoft.ActiveDirectory.Management.ADUser` or `Microsoft.ActiveDirectory.Management.ADPrincipal` with `objectClass` set to `'user'`).
Mandatory.
Specifies the unique identifier (UUID or username) of the target user, or an AD user/principal object via pipeline (`Microsoft.ActiveDirectory.Management.ADUser` or `Microsoft.ActiveDirectory.Management.ADPrincipal` with `objectClass` set to `'user'`).
Mandatory.
Specifies the unique identifier (UUID or username) of the target user, or an AD user/principal object via pipeline (`Microsoft.ActiveDirectory.Management.ADUser` or `Microsoft.ActiveDirectory.Management.ADPrincipal` with `objectClass` set to `'user'`).

```yaml
Type: System.Object
DefaultValue: None
SupportsWildcards: false
Aliases:
- SamAccountName
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: true
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserRoleId

Mandatory in `ByUserRoleId` parameter set. Specifies the unique identifier of the user role to assign.
Mandatory in `ByUserRoleId` parameter set.
Specifies the unique identifier of the user role to assign.
Mandatory in `ByUserRoleId` parameter set.
Specifies the unique identifier of the user role to assign.
Mandatory in `ByUserRoleId` parameter set.
Specifies the unique identifier of the user role to assign.

```yaml
Type: System.String
DefaultValue: None
SupportsWildcards: false
Aliases:
- Id
ParameterSets:
- Name: ByUserRoleId
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.
Shows what would happen if the cmdlet runs.
The cmdlet is not run.
Shows what would happen if the cmdlet runs.
The cmdlet is not run.
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### System.String, Microsoft.ActiveDirectory.Management.ADUser, Microsoft.ActiveDirectory.Management.ADPrincipal

Accepts user ID strings, ADUser objects, or ADPrincipal objects (with objectClass property equal to user) from the pipeline.

### System.String

Accepts user ID strings from the pipeline.

### System.Object

ADUser objects, or ADPrincipal objects (with objectClass property equal to user) from the pipeline.

## OUTPUTS

### None

This cmdlet does not generate any pipeline output upon success.

## NOTES

Requires authentication configured via `Set-RolConfiguration`.

## RELATED LINKS

{{ Fill in the related links here }}

