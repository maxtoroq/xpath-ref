param([switch]$IndexOnly)

$ErrorActionPreference = "Stop"
Push-Location (Split-Path $script:MyInvocation.MyCommand.Path)

try {

   $saxonPath = Resolve-Path ..\packages\Saxon-HE.*
   $indexOnlyXsd = $IndexOnly.ToString().ToLower()

   .\ensure-specs.ps1

   &"$saxonPath\tools\Transform" -s:.\specs\xpath-functions-31.xml -xsl:.\all-functions.xsl index-only=$indexOnlyXsd

} finally {
   Pop-Location
}