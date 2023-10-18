---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version: https://bit.ly/3PwXgsK
schema: 2.0.0
---

# Save-BitlyToken

## SYNOPSIS

Save your bitly API key or token to a secure file.

## SYNTAX

### prompt (Default)

```yaml
Save-BitlyToken [-Prompt] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### token

```yaml
Save-BitlyToken -Token <SecureString> [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use of the bitly REST API requires an API key or token, which you can setup under your account online. Most commands in this module require the token for authentication purposes. To protect the token and make it easier to use the commands, you can run Save-BitlyToken to store the token as a secure string in a file. The file is called BitlyToken.xml and is stored in your $HOME directory. You will be prompted to enter or paste your token which is immediately saved as a secure string. This string is then exported to a cliXML file. This file can only be decrypted by you on the machine where it was created.

When you import the PSBitly module, if this file is found, it will be decrypted and the value stored as a secure string in a PSDefaultParameter value for the bitly commands.

If you don't use this feature, you can use whatever technique you want to manage the API key such as the SecretManagement module. It is recommended that you set a PSDefaultParameterValue for the APIKey

$PSDefaultParameterValues["*-bitly*:APIKey"] = <your API key>

You might put this command in your PowerShell profile script.

## EXAMPLES

### Example 1

```powershell
PS C:\> Save-BitlyToken $myAPI
```

Save the token previously saved as a secure string.

### Example 2

```powershell
PS C:\>  Save-BitlyToken
Enter or paste your API key here.:
```

If you don't specify a token you will be prompted with a Read-Host command. You can type or paste the API key.

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

### -Passthru

Display the export file.

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

### -Prompt

Enter or copy your Bitly API key or token.

```yaml
Type: SwitchParameter
Parameter Sets: prompt
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token

Enter or copy your Bitly API key or token.

```yaml
Type: SecureString
Parameter Sets: token
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

### 'System.IO.FileInfo'

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
