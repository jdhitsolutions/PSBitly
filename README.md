# PSBitly

**This module is now deprecated and is no longer in development. Bitly changed their API model and pricing structure which is not compatible with this module. I am leaving the repository up for reference purposes only.**

Create and work with Bit.ly shortcut links from a PowerShell prompt. Many of the commands are based on Bitly's [v4 API Documentation](https://dev.bitly.com/v4_documentation.html). Almost all of these commands will require you to get an API Key or OAuth token under your Bit.ly account settings.

## Commands

- [Get-BitlyGroupLink](docs/Get-BitlyGroupLink.md)
- [Get-BitlyLink](docs/Get-BitlyLink.md)
- [Get-BitlyLinkSummary](docs/Get-BitlyLinkSummary.md)
- [Get-BitlyUser](docs/Get-BitlyUser.md)
- [Get-URLDetail](docs/Get-URLDetail.md)
- [New-BitlyLink](docs/New-BitlyLink.md)
- [Save-BitlyToken](docs/Save-BitlyToken.md)
- [Set-BitlyLink](docs/Set-BitlyLink.md)

## API Key

Most of the commands will rely on your Bitly API key. You can use any mechanism you want to securely store and use this value. You might store it in a secrets management vault and then make it a default parameter value.

```powershell
$APIToken = <your process to get the value>
$PSDefaultParameterValues["*-bitly*:APIKey"] = $APIToken
```

Run `Save-BitlyToken` to store the token as a secure string in a file. The file is called `BitlyToken.xml` and is stored in your `$HOME` directory. You will be prompted to enter or paste your token which is immediately saved as a secure string. This string is then exported to a cliXML file. __This file can only be decrypted by you on the machine where it was created__.

When you import the PSBitly module, if this file is found, it will be decrypted and the value stored as a secure string in a PSDefaultParameter value for the module commands.

> :exclamation: Don't forget that there are API limits. If you run repeated commands in a very short time, you might get errors about exceeding limits. All you can do is wait a bit and try again.

## Workflow

To access links, you will need your associated group id.

```powershell
PS C:\>  Get-BitlyUser

Name     : Jeffery Hicks
Email    : jhicks@jdhitsolutions.com
GroupID  : Bb3XXXXXXXX
Created  : 3/28/2011 5:37:39 AM
Modified : 11/2/2018 11:27:22 AM
```

Using $PSDefaultParameterValues will simplify using this module.

```powershell
$PSDefaultParameterValues["*-bitly*:GroupID"] = (Get-BitlyUser).GroupID
```

This will make it easier to get links.

```powershell
PS C:\> Get-BitlyGroupLink | Select Created,Link,Title -last 5

Created                Link                   Title
-------                ----                   -----
10/12/2023 10:01:44 AM https://bit.ly/48MvEsl Decoding ChatGPT Applications: 10…
10/16/2023 10:00:35 AM https://bit.ly/3S2vKGy PowerShell 7 Upgrade: A Comprehen…
10/17/2023 10:03:43 AM https://bit.ly/3QiuRby Automating Azure Resource Deploym…
10/18/2023 10:01:01 AM https://bit.ly/45GfWwa Building a Notion PowerShell Modu…
10/18/2023 11:50:42 AM https://bit.ly/46XEsKr Using the Pure Storage PowerShell…
```

Use Get-BitlyLinkSummary to see how your links are performing.

```powershell
PS C:\> Get-BitlyGroupLink | Select -last 5 | Get-BitlyLinkSummary

ID              Title                                         TotalClicks TimeSpan     Count Date
--              -----                                         ----------- --------     ----- ----
bit.ly/48MvEsl  Decoding ChatGPT Applications: 10 Strategies…           6 Day             30 10/18/2023 4:29:17 PM
bit.ly/3S2vKGy  PowerShell 7 Upgrade: A Comprehensive Walkth…          41 Day             30 10/18/2023 4:29:18 PM
bit.ly/3QiuRby  Automating Azure Resource Deployments in Pow…          20 Day             30 10/18/2023 4:29:18 PM
bit.ly/45GfWwa  Building a Notion PowerShell Module: Part 1            20 Day             30 10/18/2023 4:29:24 PM
bit.ly/46XEsKr  Using the Pure Storage PowerShellSDK2 - Part…           4 Day             30 10/18/2023 4:29:24 PM
```

## Creating a Link

Use `New-BitlyLink` to create a new link from a given url.

```powershell
PS C:\> New-BitlyLink -url https://bsky.app/profile/jeffhicks.bsky.social

Created     : 10/18/2023 4:38:02 PM
Link        : https://bit.ly/491ATVa
CustomLinks : {}
Title       :
Tags        : {}
ID          : bit.ly/491ATVa
Url         : https://bsky.app/profile/jeffhicks.bsky.social
```

You can work with links, assuming you know the ID.

```powershell
PS C:\> Get-BitlyLink -ID bit.ly/491ATVa

Created     : 10/18/2023 4:38:02 PM
Link        : https://bit.ly/491ATVa
CustomLinks : {}
Title       : @jeffhicks.bsky.social on Bluesky
Tags        : {}
ID          : bit.ly/491ATVa
Url         : https://bsky.app/profile/jeffhicks.bsky.social
```

## Modifying a Link

Use `Set-BitlyLink` to add tags or a title. Customized links are not available from the API and must be configured online.

```powershell
PS C:\> Set-BitlyLink -ID bit.ly/491ATVa -Tags social

Created     : 10/18/2023 4:38:02 PM
Link        : https://bit.ly/491ATVa
CustomLinks : {}
Title       :
Tags        : {social}
ID          : bit.ly/491ATVa
Url         : https://bsky.app/profile/jeffhicks.bsky.social
```

You can leverage the pipeline to create the link and update is one statement.

```powershell
PS C:\> > New-BitlyLink -url https://techhub.social/@JeffHicks | Set-BitlyLink -Tag social -title "Jeff Hicks on Mastodon"

Created     : 10/18/2023 4:57:32 PM
Link        : https://bit.ly/3rOjoHn
CustomLinks : {}
Title       : Jeff Hicks on Mastodon
Tags        : {social}
ID          : bit.ly/3rOjoHn
Url         : https://techhub.social/@**JeffHicks**
```

## RoadMap

The module can only do what the API allows. The module commands currently meet all of my needs although, there are open issues to improve the user experience. I am open to suggestions and PRs.
