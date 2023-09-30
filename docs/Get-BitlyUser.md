---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Get-BitlyUser

## SYNOPSIS

Get your bitly user object

## SYNTAX

```yaml
Get-BitlyUser [-APIKey] <SecureString> [<CommonParameters>]
```

## DESCRIPTION

Use this command to get your bitly user object. You might need the GroupID value for other commands.

## EXAMPLES

### Example 1

```powershell
PS C:\> get-bitlyuser


Name     : Art Deco
Email    : artd@Company.com
GroupID  : Xb3s9XYawRX
Created  : 3/28/2017 5:37:39 AM
Modified : 11/2/2018 11:27:22 AM
```

## PARAMETERS

### -APIKey

Enter your Bitly API token.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSBitlyUser

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-BitlyGroupLinks](Get-BitlyGroupLinks.md)
