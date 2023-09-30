# Change Log for PSBitly

## [Unreleased]

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

[Unreleased]: https://github.com/jdhitsolutions/PSBitly/compare/v0.5.0..HEAD
