
# Import the parent module to test

if (Get-Module -Name PSBitly) {
    Remove-Module -Name PSBitly
}
$ModuleManifestPath = "$PSScriptRoot\..\psbitly.psd1"

Import-Module $ModuleManifestPath -force

InModuleScope PSBitly {
    Describe ModuleStructure {
        It 'Passes Test-ModuleManifest' {
            {Test-ModuleManifest -Path "$PSScriptRoot\..\PSBitly.psd1"} | Should -not -Throw
        }

        $psdata = (Get-Module PSBitly ).PrivateData.psdata
        It "Should have a project uri" {
            $psdata.projecturi | Should -Match "^http"
        } -pending

        It "Should have one or more tags" {
            $psdata.tags.count | Should -BeGreaterThan 0
        } -pending

        It "Should have markdown documents folder" {
            Get-Childitem $psscriptroot\..\docs\*md | Should -Exist
        } -pending

        It "Should have an external help file" {
            $cult = (Get-Culture).name
            Get-Childitem $psscriptroot\..\$cult\*-help.xml | Should -Exist
        } -pending

        It "Should have a README file" {
            Get-Childitem $psscriptroot\..\README.md | Should -Exist
        }

        It "Should have a License file" {
            Get-Childitem $psscriptroot\..\License.txt | Should -Exist
        }
    }


} #in module scope
