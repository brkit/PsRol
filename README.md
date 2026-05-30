# PsRol (PowerShell Module for OS2Rollekatalog)

## Description

**PsRol** is a [PowerShell](https://github.com/powershell/powershell)-based module containing a collection of functions related to the "V2 API" for [OS2Rollekatalog](https://github.com/OS2rollekatalog/OS2rollekatalog) created in connection with various Automation Tasks in Bornholms Regionskommune.

Licensed under EUPL-1.2 the project contains original source code which can be built and distributed under the terms of the license.

### Note from the author

**PsRol** has been written as needs arose in connection with my work, as such **PsRol** is very much a _work in progress_ and as such is not distributed as a PowerShell Module but as source code, which can be built using the instructions [below](#development).

## Installation

### Prerequisites

The module is set up with PowerShell 7.6 as the minimum version and no testing is done towards older PowerShell versions, though the module may function as-is, by decreasing `PowerShellHostVersion` to a lower version, it will **not** work on Windows PowerShell without code changes.

Follow the build instructions in the [Development](#development) section and then import the module using `Import-Module PsRol`

## Usage

### Initial configuration

After importing the module, you will need to supply the Base URL to your OS2rollekatalog instance, as well as an API Key with appropriate permissions for OS2rollekatalog.

```powershell
Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey '<ApiKey>'
```

The configuration can optionally be persisted as a DotFile in your home directory `~\.PsRolConfig.json` using the following command, but it will not save your API Key.

```powershell
Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey '<ApiKey>' -AsDotFile
```

#### I want to save my API Key anyway

Obviously not recommended, as there is no security, but the API key can nevertheless be persisted by adding the `-ApiKeyInDotFile` switch.

```powershell
Set-RolConfiguration -BaseUrl 'https://kommune.rollekatalog.dk' -ApiKey '<ApiKey>' -AsDotFile -ApiKeyInDotFile
```

### Example usage

#### Retrieving userroles

`Get-RolUserRole` allows you to return the UserRoleId, Name and Description of currently defined UserRoles in Rollekatalog. Wildcards can be used.

```powershell
# Get all userroles named 'Demo Fagsystem: Opdater_sag'
Get-RolUserRole -Name 'Demo Fagsystem: Opdater_sag'
# Get all userroles starting with 'Demo Fagsystem:'
Get-RolUserRole -Name 'Demo Fagsystem:*'
# Get all userroles containing 'Demo Fagsystem:'
Get-RolUserRole -Name '*Demo Fagsystem:*'
```

#### Adding users to an existing userrole

You can assign users to a specific User Role using `Add-RolAssignUserRole' with the Username, User Role Id, and optionally specify additional  parameters such as start/stop-date and domain.

```powershell
# Adding the user to a specified role
Add-RolAssignUserRole -UserRoleId 123 -UserId abc123

# Adding the user to a specified role for a limited time, assigned in a week, assignment lasting a week
Add-RolAssignUserRole -UserRoleId 123 -UserId abc123 -StartDate (Get-Date).AddDays(7) -EndDate (Get-Date).AddDays(14)

# Specifying domain. If unspecified "Administrativt" is used
Add-RolAssignUserRole -UserRoleId 123 -UserId abc123 -Domain 'Skole'

```

#### Creating a new User Role

If you want to create a new user role, you can use `New-RolUserRole`. Depending on your needs you may need to use `New-RolSystemRoleAssignment` and `New-RolConstraintValue`.

Note: Currently the following is unsupported:

- Postponed constraints
- Constraints using a different `ConstraintValueType` from `VALUE`
- Specifying Approval/Request permissions, currently it defaults to INHERIT for all user roles created using this Cmdlet

```powershell
# First, create the parameters
$Params = @{
    Name = 'Demo Fagsystem: Opdater_sag'
    Description = 'Gives opdater_sag permission in Demo Fagsystem'
    SensitiveRole = $true
    # Corresponds to "Demo Fagsystem" in KOMBIT
    ItSystemId = 61
    # SystemRoleId 89 corresponds to the ID of opdater_sag in Demo Fagsystem
    # ConstraintTypeId 61 is for Organisation
    # Get-RolOrganisation gets the Organisation UUID for a specified unit in your rollekatalog instance 
    # Optionally a string containing the UUID can also be passed to the ConstraintValue parameter. 
    # If the Constraint supports regex, it is validated before being passed to the API.
    SystemRoleAssignment = New-RolSystemRoleAssignment -SystemRoleId 89 -ConstraintValues (New-RolConstraintValue -ConstraintTypeId 61 -ConstraintValue (Get-RolOrganisation 'Center for Eksempler').uuid)
}

# Then, create the new user role
New-RolUserRole @Params
```

#### Creating a new It System

Creating new It systems can be done with the Cmdlet `New-RolItSystem`, currently not all parameters are supported, for example canEditThroughApi is forced to true, so it can be edited using the API afterwards. Similarly AD-systems cannot be created "unpaused" which is a limitation/feature of the API.

```powershell
# Creating a Simple It System
New-RolItSystem -Name 'Test' -SystemIdentifier 'Simple-Test' -ItSystemType MANUAL

# Creating an AD It System and setting it to Hidden
New-RolItSystem -Name 'Test' -SystemIdentifier 'Simple-Test' -ItSystemType AD -Hidden

# Creating a SAML It System and setting it to paused and domain 'Skole'
New-RolItSystem -Name 'Test' -SystemIdentifier 'Simple-Test' -ItSystemType SAML -Paused -Domain Skole
```

## Development

The module is created using [ModuleTools](https://github.com/belibug/ModuleTools) as a lightweight scaffolding tool for PowerShell modules, the module can be built by following the instructions below.

### Development Prerequisites

- [Git](https://git-scm.com/)
- [ModuleTools](https://www.powershellgallery.com/packages/ModuleTools)

### Instructions

Clone the repository:

```shell
git clone https://github.com/brkit/PsRol.git
```

Build the module:

```powershell
cd PsRol
Invoke-MTBuild
```

### Build Output

After building the module can be found in the dist-folder, and imported using `Import-Module`.

```text
dist
└── PsRol
    ├── PsRol.psd1
    └── PsRol.psm1
```

## Contributing

The project is not currently accepting contributions, however the repository can be downloaded and source altered in accordance with the license terms.
