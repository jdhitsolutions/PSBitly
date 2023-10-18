---
external help file: PSBitly-help.xml
Module Name: PSBitly
online version: https://bit.ly/48wII59
schema: 2.0.0
---

# Get-BitlyLinkSummary

## SYNOPSIS

Get a summary of clicks for a bitly link.

## SYNTAX

```yaml
Get-BitlyLinkSummary [-ID] <String> -APIKey <SecureString> [-TimeSpan <String>] [-Count <Int32>] [-Size <Int32>] [<CommonParameters>]
```

## DESCRIPTION

You can use this command to get a summary of clicks for a given bitly link over a specified time frame.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-BitlyLinkSummary bit.ly/3PHxVgZ  -TimeSpan Month | Format-List


ID          : bit.ly/3PHxVgZ
Title       : PowerShellGet 3.0.22-beta22 is now available - PowerShell Team
TotalClicks : 8
TimeSpan    : Month
Count       : 1
Date        : 9/30/2023 4:30:36 PM

```

Get a link summary for the last 1 month.

### Example 2

```powershell
PS C:\> Get-BitlyGroupLink -CreatedAfter 7/1/2023  | Get-BitlyLinkSummary -TimeSpan Month -Count -1 | Sort-Object TotalClicks -Descending | Select-Object ID,TotalClicks,Title -first 10

ID             TotalClicks Title
--             ----------- -----
bit.ly/3Pco9C9          72 Announcing PowerShell Crescendo 1.1.0 General Avai...
bit.ly/3sJRFrr          41 A Guide to Using Certutil for Certificate Management
bit.ly/46qzkye          24 Mastering the Windows Kill Process: A Comprehensiv...
bit.ly/4876og7          21 PSResourceGet Release Candidate is Now Available -...
bit.ly/48AIUjA          15 Release mySQLite_v0.12.0 Â· jdhitsolutions/MySQLit...
bit.ly/48wKR0t          14 NPM on Windows: Your Complete Installation Guide f...
bit.ly/3t1iAiF          14 whoami: A Comprehensive Guide to OS User Identific...
bit.ly/3LhuCe0          12 Redis on Windows: A Comprehensive Installation Guide
bit.ly/3ru5rOs          11 Release PSWorkItem_v1.3.0 Â· jdhitsolutions/PSWork...
bit.ly/3Z4GiGB          10 HOOBS & Raspberry Pi: The Perfect DIY Smart Home C...
```

Get the top ten links based on click count over the last mont, on links created after July 1, 2023.

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

### -TimeSpan

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
