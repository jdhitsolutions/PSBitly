---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version: https://bit.ly/46bfk2K
schema: 2.0.0
---

# New-BitlyLink

## SYNOPSIS

Create a new bitly link

## SYNTAX

```yaml
New-BitlyLink [-Url] <String> -APIKey <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Create a new bitly link from a given url. You can use Set-Bitlylink to customize it once it has been created.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-BitlyLink -url  https://github.com/jdhitsolutions/jdhitsolutions

Created     : 4/8/2021 11:34:07 AM
Link        : https://bit.ly/3fUJsIb
CustomLinks : {}
Title       :
Tags        : {}
ID          : bit.ly/3fUJsIb
Url         : https://github.com/jdhitsolutions/jdhitsolutions
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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url

Enter the long url to shorten

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Set-BitlyLink](Set-BitlyLink.md)
