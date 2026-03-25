# PsRol (PowerShell Module for OS2Rollekatalog)

## Description

**PsRol** is a [PowerShell](https://github.com/powershell/powershell)-based module containing a collection of functions related to the "V2 API" for [OS2Rollekatalog](https://github.com/OS2rollekatalog/OS2rollekatalog) created in connection with various Automation Tasks in Bornholms Regionskommune.

Licensed under EUPL-1.2 the project contains original source code which can be built and distributed under the terms of that license.

### Note from the author

**PsRol** has been written as needs arose in connection with my work, as such **PsRol** is not distributed as a PowerShell Module but as source code, which can be built using the instructions [below](#development).

## Installation

### Prerequisites

The module is set up with PowerShell 7.6 as the minimum version and no testing is done towards older PowerShell versions, though they may function as-is by decreasing `PowerShellHostVersion` to a lower version. It will **not** work on Windows PowerShell without code changes.

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

## Development

The module is created using [ModuleTools](https://github.com/belibug/ModuleTools) as a lightweight scaffolding tool for PowerShell modules, the module can be built by following the instructions below.

### Prerequisites

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
