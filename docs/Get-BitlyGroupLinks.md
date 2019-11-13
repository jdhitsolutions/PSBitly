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
Get-BitlyGroupLinks [-GroupID] <String> -APIKey <SecureString> [-Size <Int32>] [-Tags <String[]>]
 [-Filter <String>] [-CreatedBefore <DateTime>] [-CreatedAfter <DateTime>] [-ModifiedAfter <DateTime>]
 [<CommonParameters>]
```

## DESCRIPTION

Use this command to get links associated with your group ID which you can find as part of your user object.

## EXAMPLES

### Example 1

```powershell
PS C:\>  Get-BitlyUser | Get-BitlyGroupLinks

Created     : 10/21/2019 5:12:15 AM
Link        : http://bit.ly/2oY3qty
CustomLinks : {}
Title       : Securing PowerShell
Tags        : {class, PowerShell}
ID          : bit.ly/2oY3qty
Url         : https://www.dropbox.com/s/353ndxn9ntowmlf/SecuringPowerShell.zip

Created     : 9/22/2019 7:46:54 PM
Link        : http://bit.ly/2kZgOeW
CustomLinks : {http://bit.ly/PowerShell-Advanced-Spiceworld2019}
Title       : PowerShell Advanced Spiceworld 2019
Tags        : {conference, powershell}
ID          : bit.ly/2kZgOeW
Url         : https://www.dropbox.com/s/7kdjfc7fvvjvjtr/PowerShell-Advanced-Spiceworld2019.zip?dl=0

Created     : 9/22/2019 7:44:45 PM
Link        : http://bit.ly/2mvnz8X
CustomLinks : {http://bit.ly/PowerShell-Fundamentals-Spiceworld2019}
Title       : PowerShell Fundamentals Spiceworld 109
Tags        : {conference, powershell}
ID          : bit.ly/2mvnz8X
Url         : https://www.dropbox.com/s/pjal0m0lgxeds8h/PowerShell-Fundamentals-Spiceworld2019.zip?dl=0

...
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

### System.Object

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-BitlyUser]()

[Get-BitlyLink]()