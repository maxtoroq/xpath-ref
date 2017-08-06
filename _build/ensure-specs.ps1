$ErrorActionPreference = "Stop"
Push-Location (Split-Path $script:MyInvocation.MyCommand.Path)

$specs = @(
   "http://www.w3.org/TR/2017/REC-xpath-functions-31-20170321/xpath-functions-31.xml"
   , "http://www.w3.org/TR/2014/REC-xpath-functions-30-20140408/xpath-functions-30.xml"
   , "http://www.w3.org/TR/2010/REC-xpath-functions-20101214/xpath-functions-20101214.xml"
   , "https://www.w3.org/TR/2017/REC-xpath-31-20170321/xpath-31.xml"
   , "https://www.w3.org/TR/2017/REC-xpath-datamodel-31-20170321/xpath-datamodel-31.xml"
   , "http://www.w3.org/TR/2014/REC-xpath-datamodel-30-20140408/xpath-datamodel-30.xml"
   , "https://www.w3.org/TR/2017/REC-xslt-xquery-serialization-31-20170321/xslt-xquery-serialization-31.xml"
)

try {

   if (-not (Test-Path specs -PathType Container)) {
      md specs | Out-Null
   }

   foreach ($url in $specs) {
      
      $fileName = Split-Path $url -Leaf

      if (-not (Test-Path .\specs\$fileName)) {
         write "Downloading $fileName"
         Invoke-WebRequest $url -OutFile .\specs\$fileName
      }
   }

} finally {
   Pop-Location
}