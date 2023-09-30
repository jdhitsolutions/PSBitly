---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Set-BitlyLink

## SYNOPSIS

Modify an existing bitly link.

## SYNTAX

```yaml
Set-BitlyLink [-ID] <String> [-Title <String>] [-Tags <String[]>] [-Archive] -APIKey <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

You this command to update an existing link. You might want to add a tag or title. Custom links must be added manually online.

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-BitlyLink -id bit.ly/32GPRwt -title "Open Source PowerShell" -tags "github","powershell"


Created     : 11/13/2019 4:19:55 PM
Link        : http://bit.ly/32GPRwt
CustomLinks : {}
Title       : Open Source PowerShell
Tags        : {github, powershell}
ID          : bit.ly/32GPRwt
Url         : https://github.com/powershell/powershell
```

## PARAMETERS

### -APIKey

Enter your Bitly API token

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

### -Archive

THIS PARAMETER IS UNDER DEVELOPMENT

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
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

### -Tags

specify a set of tags

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

Add a title

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

[New-BitlyLink](New-BitlyLink.md)
