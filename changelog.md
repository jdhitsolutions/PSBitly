# Change Log for PSBitly

## [Unreleased]

## [0.7.0] - 2024-08-07

### Added

- Added command `Export-BitlyConfiguration` [[Issue #3](https://github.com/jdhitsolutions/PSBitly/issues/3)]
- Added the alias `Export-BitlyToken` to `Save-BitlyToken`.
- Added missing online help links

### Changed

- Updated `README.md`.

## [0.6.0] - 2023-10-18

### Added

- Migrated public functions to separate files.
- Added missing online help links

### Changed

- Renamed `Get-BitlyGroupLinks` to `Get-BitGroupLink`. _This is a breaking change_.
- Updated `Save-BitlyToken` to let the user pass a token as a secure string as a parameter value or from the pipeline. The default behavior is to prompt the user with a `Read-Host` command so they can type or paste the API key.
- Revised `Get-BitlyGroupLinks` to sort output on data by default.
- Updated help documentation.
- Updated `README.md`.
- Updated Pester tests.

## [0.5.0] - 2023-09-30

- added `about_psbitly` help topic
- Updated `README.md`
- Updated `license.txt`

## [0.4.0] - 2019-11-13

- Added `Save-BitlyToken` to store API key as an exported secure string
- Modified module to load the stored API as a default parameter value for bitly commands
- Modified commands to accept a secure string for the API key
- Added formatting file for `urldetail` type
- Added command help documentation
- Updated `README.md`

## [0.3.0] - 2019-11-07

- Created custom object output for bitly links using a PowerShell class
- Created custom object output for bitly user using a PowerShell class
- Created private functions for instantiating new class instances
- Changed typename output for `Get-BitlyLinkSummary`
- Added type and format extensions
- Added table format definition for PSBitlySummary objects
- Added DisableKeepAlive and UseBasicParsing to Invoke-RestMethod parameter hashtables

## v0.2.0

- Modified `Get-URLDetail` to better handle links that don't have a document title
- Updated `README.md`
- Added help documentation

## v0.1.0

- initial files

[0.7.0]: (https://github.com/jdhitsolutions/PSBitly/compare/v0.6.0..v0.7.0)
[0.6.0]: https://github.com/jdhitsolutions/PSBitly/compare/v0.5.0..v0.6.0