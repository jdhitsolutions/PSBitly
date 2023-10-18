
# Import the parent module to test

if (Get-Module -Name PSBitly) {
    Remove-Module -Name PSBitly
}
$ModuleManifestPath = "$PSScriptRoot\..\psbitly.psd1"

Import-Module $ModuleManifestPath -Force

InModuleScope PSBitly {
    Describe ModuleStructure {
        BeforeAll {
            $ThisModule = Get-Module PSBitly
            $PSData = $thisModule.PrivateData.PSData
        }
        It 'Passes Test-ModuleManifest' {
            { Test-ModuleManifest -Path "$PSScriptRoot\..\PSBitly.psd1" } | Should -Not -Throw
        }

        It 'Should have a project description' {
            $ThisModule.Description -match '\w+'
        }

        It 'Should have standard authorship information' {
            $ThisModule.Author | Should -Be 'Jeff Hicks'
            $ThisModule.CompanyName | Should -Be 'JDH Information Technology Solutions, Inc.'
        }

        It 'Should have a project uri' {
            $PSData.ProjectURI | Should -Match '^http'
        }

        It 'Should have one or more tags' {
            $PSData.tags.count | Should -BeGreaterThan 0
        }

        It 'Should have markdown documents folder' {
            Get-ChildItem $PSScriptRoot\..\docs\*md | Should -Exist
        }

        It 'Should have an external help file' {
            $cult = (Get-Culture).name
            Get-ChildItem $PSScriptRoot\..\$cult\*-help.xml | Should -Exist
        }

        It 'Should have a README file' {
            Get-ChildItem $PSScriptRoot\..\README.md | Should -Exist
        }

        It 'Should have a License file' {
            Get-ChildItem $PSScriptRoot\..\License.txt | Should -Exist
        }

        It 'Should have two exported format files' {
            $ThisModule.ExportedFormatFiles.Count | Should -Be 2

        }
    }


    Describe Save-BitlyToken {
        It 'Should have help documentation' {
        (Get-Help Save-BitlyToken).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Save-BitlyToken).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Save-BitlyToken } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-URLDetail {
        It 'Should have help documentation' {
        (Get-Help Get-URLDetail).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-URLDetail).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-URLDetail } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Set-BitlyLink {
        It 'Should have help documentation' {
        (Get-Help Set-BitlyLink).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Set-BitlyLink).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Set-BitlyLink } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe New-BitlyLink {
        It 'Should have help documentation' {
        (Get-Help New-BitlyLink).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name New-BitlyLink).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { New-BitlyLink } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BitlyUser {
        It 'Should have help documentation' {
        (Get-Help Get-BitlyUser).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BitlyUser).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BitlyUser } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BitlyLinkSummary {
        It 'Should have help documentation' {
        (Get-Help Get-BitlyLinkSummary).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BitlyLinkSummary).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BitlyLinkSummary } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BitlyLink {
        It 'Should have help documentation' {
        (Get-Help Get-BitlyLink).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BitlyLink).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BitlyLink } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function
    Describe Get-BitlyGroupLinks {
        It 'Should have help documentation' {
        (Get-Help Get-BitlyGroupLinks).Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a defined output type' {
        (Get-Command -CommandType function -Name Get-BitlyGroupLinks).OutputType | Should -Not -BeNullOrEmpty
        }
        It 'Should run without error' {
            <#
        mock and set mandatory parameters as needed
        this test is marked as pending since it
        most likely needs to be refined
        #>
            { Get-BitlyGroupLinks } | Should -Not -Throw
        } -Pending
        #insert additional command-specific tests

    } -Tag function

} #in module scope
