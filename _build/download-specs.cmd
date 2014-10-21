IF NOT EXIST specs md specs

IF NOT EXIST .\specs\xpath-functions-30.xml @powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object System.Net.WebClient).DownloadFile('http://www.w3.org/TR/2014/REC-xpath-functions-30-20140408/xpath-functions-30.xml', '.\specs\xpath-functions-30.xml')"

IF NOT EXIST .\specs\xpath-functions.xml @powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object System.Net.WebClient).DownloadFile('http://www.w3.org/TR/2010/REC-xpath-functions-20101214/xpath-functions-20101214.xml', '.\specs\xpath-functions.xml')"

IF NOT EXIST .\specs\xpath-30.xml @powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object System.Net.WebClient).DownloadFile('http://www.w3.org/TR/2014/REC-xpath-30-20140408/xpath-30.xml', '.\specs\xpath-30.xml')"

IF NOT EXIST .\specs\xpath-datamodel-30.xml @powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object System.Net.WebClient).DownloadFile('http://www.w3.org/TR/2014/REC-xpath-datamodel-30-20140408/xpath-datamodel-30.xml', '.\specs\xpath-datamodel-30.xml')"

IF NOT EXIST .\specs\xslt-xquery-serialization-30.xml @powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; (New-Object System.Net.WebClient).DownloadFile('http://www.w3.org/TR/2014/REC-xslt-xquery-serialization-30-20140408/xslt-xquery-serialization-30.xml', '.\specs\xslt-xquery-serialization-30.xml')"