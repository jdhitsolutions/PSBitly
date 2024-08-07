---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version: https://bit.ly/47fUYWl
schema: 2.0.0
---

# Get-BitlyGroupLink

## SYNOPSIS

Get bitly links associated with your group

## SYNTAX

```yaml
Get-BitlyGroupLink [-GroupID] <String> -APIKey <SecureString> [-Size <Int32>] [-Tags <String[]>]  [-Filter <String>] [-CreatedBefore <DateTime>] [-CreatedAfter <DateTime>] [-ModifiedAfter <DateTime>]  [<CommonParameters>]
```

## DESCRIPTION

Use this command to get all links associated with your group ID which you can find as part of your user object. You might want to set a default parameter value for the GroupID:

$PSDefaultParameterValues["*-bitly*:GroupID"] = (Get-BitlyUser).GroupID

This example assumes you've already set a default parameter value for the APIKey.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BitlyUser | Get-BitlyGroupLink | Select-Object -last 3


Created     : 9/30/2023 10:39:23 AM
Link        : https://bit.ly/3tiB3HC
CustomLinks : {}
Title       : PSBitly Get-BitlyGroupLink Help
Tags        : {github, powershell}
ID          : bit.ly/3tiB3HC
Url         : https://github.com/jdhitsolutions/PSBitly/blob/master/docs/Get-Bit
              lyGroupLinks.md

Created     : 9/30/2023 10:39:28 AM
Link        : https://bit.ly/48wII59
CustomLinks : {}
Title       : PSBitly Get-BitlyLinkSummary Help
Tags        : {github, powershell}
ID          : bit.ly/48wII59
Url         : https://github.com/jdhitsolutions/PSBitly/blob/master/docs/Get-Bit
              lyLinkSummary.md

Created     : 9/30/2023 10:39:34 AM
Link        : https://bit.ly/3PwXgsK
CustomLinks : {}
Title       : PSBitly Save-BitlyToken Help
Tags        : {github, powershell}
ID          : bit.ly/3PwXgsK
Url         : https://github.com/jdhitsolutions/PSBitly/blob/master/docs/Save-Bi
              tlyToken.md
```

This example assumes you have set a PSDefaultParameterValue to specify the APIKey.

### Example 2

```powershell
PS C:\> Get-BitlyUser | Get-BitlyGroupLink -CreatedAfter 9/1/2023 | Select-Object Link ,Title -first 5

Link                   Title
----                   -----
https://bit.ly/3qTHm3x Troubleshooting and Fixing Kubernetes CrashLoopBackOff
https://bit.ly/3sJRFrr A Guide to Using Certutil for Certificate Management
https://bit.ly/3Z4GiGB HOOBS & Raspberry Pi: The Perfect DIY Smart Home Combo
https://bit.ly/4876og7 PSResourceGet Release Candidate is Now Available - Pow...
https://bit.ly/462MKjw OnyX macOS: Your Ultimate Guide to Installation and Usage
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

### -CreatedAfter

Filter for links created after this date.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedBefore

Filter for links created before this date.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Enter a key word or phrase to filter on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupID

Enter your Bitly group GUID or ID.

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

### -ModifiedAfter

Filter for links modified after this date.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size

Specify the number of links to return. The default is 50. The limit for this command is 1000.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Filter links by tags.

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

[Get-BitlyUser](Get-BitlyUser.md)

[Get-BitlyLink](Get-BitlyLink.md)
