---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version:
schema: 2.0.0
---

# Get-BitlyLinkSummary

## SYNOPSIS

Get a summary of clicks for a bitly link.

## SYNTAX

```yaml
Get-BitlyLinkSummary [-ID] <String> -APIKey <SecureString> [-Timespan <String>] [-Count <Int32>] [-Size <Int32>] [<CommonParameters>]
```

## DESCRIPTION

You can use this command to get a summary of clicks for a given bitly link over a specified time frame.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BitlyLinkSummary bit.ly/39MTiZ8 -Timespan month -Count 1

ID             TotalClicks Timespan Count Date
--             ----------- -------- ----- ----
bit.ly/39MTiZ8 70                   1     4/8/2021 11:48:22 AM
```

Get a link summary for the last 1 months.

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

### -Count

An integer representing the time units to query data for. Use -1 to return all units of time.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: -1
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

### -Size

The number of items to return.

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

### -Timespan

Enter a unit of time

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: day, minute, hour, week, month

Required: False
Position: Named
Default value: day
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### PSBitlySummary

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-BitlyLink](Get-BitlyLink.md)
