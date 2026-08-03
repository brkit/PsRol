---
document type: cmdlet
external help file: PsRol-Help.xml
HelpUri: ''
Locale: en-US
Module Name: PsRol
ms.date: 08-03-2026
PlatyPS schema version: 2024-05-01
title: Receive-RolReport
---

# Receive-RolReport

## SYNOPSIS

Requests and downloads a user role report from OS2rollekatalog for a specific date.

## SYNTAX

### __AllParameterSets

```
Receive-RolReport [-ReportDate] <datetime> [[-OutFile] <string>] [<CommonParameters>]
```

## ALIASES

None.


## DESCRIPTION

The `Receive-RolReport` cmdlet requests a user role report from OS2rollekatalog by posting a query payload to `/api/v2/report`.

It formats `-ReportDate` as `yyyy-MM-dd` and submits report filter options (defaulting to returning user roles). If `-OutFile` is specified, the resulting report data is written to the destination file.

## EXAMPLES

### Example 1: Request a report for a specific date

```powershell
PS C:\> Receive-RolReport -ReportDate (Get-Date)
```

Requests the user role report for today's date.

### Example 2: Save report output to a file

```powershell
PS C:\> Receive-RolReport -ReportDate (Get-Date) -OutFile 'C:\Reports\UserRoleReport.xlsx'
```

Downloads and saves the report to `C:\Reports\UserRoleReport.xlsx`.

## PARAMETERS

### -OutFile

Specifies the output file path where the report content will be saved.

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

### -ReportDate

Mandatory. Specifies the effective date for generating the report.

```yaml
Type: System.DateTime
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### System.Object

Returns the file path string if `-OutFile` is specified, or the API response object.

## NOTES

## RELATED LINKS

