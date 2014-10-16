@echo off
cd %~dp0

call .\download-specs.cmd
..\packages\Saxon-HE.9.5.1.6\tools\Transform.exe -s:http://www.w3.org/TR/2014/REC-xpath-functions-30-20140408/xpath-functions-30.xml -xsl:..\_xsl\all-functions.xsl