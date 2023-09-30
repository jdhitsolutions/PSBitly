---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Save-BitlyToken

## SYNOPSIS

Save your bitly API key or token to a secure file.

## SYNTAX

```yaml
Save-BitlyToken [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use of the bitly REST API requires an API key or token, which you can setup under your account online. Most commands in this module require the token for authentication purposes. To protect the token and make it easier to use the commands, you can run Save-BitlyToken to store the token as a secure string in a file. The file is called BitlyToken.xml and is stored in your $home (~) directory. You will be prompted to enter or paste your token which is immediately saved as a secure string. This string is then exported to a cliXML file. This file can only be decrypted by you on the machine where it was created.

When you import the PSBitly module, if this file is found, it will be decrypted and the value stored as a secure string in a PSDefaultParameter value for the bitly commands.

## EXAMPLES

### Example 1

```powershell

PS C:\> Save-BitlyToken -WhatIf
Enter or copy your Bitly API key or token.: *********************
```

You should be able to paste the token at the Read-Host prompt.

## PARAMETERS

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

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
