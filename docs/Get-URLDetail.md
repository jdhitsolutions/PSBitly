---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Get-URLDetail

## SYNOPSIS

Get online details from a url.

## SYNTAX

```yaml
Get-URLDetail [-URL] <String> [<CommonParameters>]
```

## DESCRIPTION

This command will retrieve metadata about a given URL using Invoke-WebRequest. It should work for any URL.

## EXAMPLES

### Example 1

```powershell
PS C:\> get-urldetail http://bit.ly/3tdSofy

URL         : http://bit.ly/3tdSofy
AbsoluteURL : https://adamtheautomator.com/add-computer-to-domain/
Title       : How to Add a Computer to a Domain [All the Ways]
Date        : 4/7/2021 1:09:28 PM
```

## PARAMETERS

### -URL

Enter a URL in the form http:// or https://

```yaml
Type: String
Parameter Sets: (All)
Aliases: link

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

### urlDetail

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WebRequest]()
