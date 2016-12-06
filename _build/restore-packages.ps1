$ErrorActionPreference = "Stop"
Push-Location (Split-Path $script:MyInvocation.MyCommand.Path)

$nuget = "..\.nuget\nuget.exe"

try {

   ./ensure-nuget.ps1

   &$nuget restore ..\packages.config

} finally {
   Pop-Location
}