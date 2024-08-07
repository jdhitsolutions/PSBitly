---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Export-BitlyConfiguration

## SYNOPSIS

Export Bitly user settings to a file.

## SYNTAX

```yaml
Export-BitlyConfiguration [-APIKey] <SecureString> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command will export Bitly user settings to a file. The file will be a JSON formatted file stored in $HOME. When you import the module, this file will be imported and used to set a default parameter value for the GroupID parameter.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-BitlyConfiguration
```

Use -Passthru to see the file result.

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

### -PassThru

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

### None

## OUTPUTS

### None

### System.IO.FileInfo

## NOTES

## RELATED LINKS

[Save-BitlyToken](Save-BitlyToken.md)
