---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Get-BitlyLink

## SYNOPSIS

Get a bitly link object

## SYNTAX

```yaml
Get-BitlyLink [-ID] <String> -APIKey <SecureString> [<CommonParameters>]
```

## DESCRIPTION

If you have a bitly link, like bit.ly/ABC123, you can use this command to retrieve the link object from the bitly service.

## EXAMPLES

### Example 1

```powershell
PS C:\> get-bitlylink -id bit.ly/2oY3qty


Created     : 10/21/2019 5:12:15 AM
Link        : http://bit.ly/2oY3qty
CustomLinks : {}
Title       : Securing PowerShell
Tags        : {class, PowerShell}
ID          : bit.ly/2oY3qty
Url         : https://www.dropbox.com/s/353ndxn9ntowmlf/SecuringPowerShell.zip
```

## PARAMETERS

### -APIKey

Enter your Bitly API token.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID

Enter the bitly link i.e. bit.ly/\<short\>

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSBitlyLink

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-BitlyGroupLinks](Get-BitlyGroupLinks.md)
