$baseUrl = "https://raw.githubusercontent.com/jincod/build-scripts/master/"

Invoke-WebRequest http://cakebuild.net/download/bootstrapper/windows -OutFile build.ps1
Invoke-WebRequest "${baseUrl}/build-scripts/build.cake" -OutFile build.cake
Invoke-WebRequest "${baseUrl}/build-scripts/build.cmd" -OutFile build.cmd