---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Get-BitlyGroupLinks

## SYNOPSIS

Get bitly links associated with your group

## SYNTAX

```yaml
Get-BitlyGroupLinks [-GroupID] <String> -APIKey <SecureString> [-Size <Int32>] [-Tags <String[]>] [-Filter <String>] [-CreatedBefore <DateTime>]
-CreatedAfter <DateTime>] [-ModifiedAfter <DateTime>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get links associated with your group ID which you can find as part of your user object.

## EXAMPLES

### Example 1

```powershell
PS C:\>  Get-BitlyUser | Get-BitlyGroupLinks

Created     : 4/8/2021 9:01:47 AM
Link        : https://bit.ly/3tdSofy
CustomLinks : {}
Title       : How to Add a Computer to a Domain [All the Ways]
Tags        : {}
ID          : bit.ly/3tdSofy
Url         : https://adamtheautomator.com/add-computer-to-domain/

Created     : 4/7/2021 10:59:17 AM
Link        : https://bit.ly/3wzzL7X
CustomLinks : {}
Title       : CloudSkills.fm
Tags        : {}
ID          : bit.ly/3wzzL7X
Url         : https://cloudskills.fm/episodes/114-BI8Ng7H9

Created     : 4/7/2021 10:01:48 AM
Link        : https://bit.ly/2OyV4pi
CustomLinks : {}
Title       : How to Run Remote Commands with the Ansible Shell Module
Tags        : {}
ID          : bit.ly/2OyV4pi
Url         : https://adamtheautomator.com/ansible-shell/
...
```

This example assumes you have set a PSDefaultParameterValue to specify the APIKey.

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
