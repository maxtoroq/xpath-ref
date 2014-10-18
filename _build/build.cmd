call .\download-specs.cmd

..\packages\Saxon-HE.9.5.1.6\tools\Transform.exe -s:.\specs\xpath-functions-30.xml +spec-v2=.\specs\xpath-functions.xml -xsl:..\_xsl\all-functions.xsl index-only=%1