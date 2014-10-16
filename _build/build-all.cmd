@echo off
cd %~dp0

call .\download-specs.cmd
..\packages\Saxon-HE.9.5.1.6\tools\Transform.exe -s:.\specs\xpath-functions-30.xml -xsl:..\_xsl\all-functions.xsl