properties {
    $ProjectDir = Resolve-Path ".\.."
    $nuget = "$ProjectDir\.nuget\nuget.exe"
    $PackagesDir = "$ProjectDir\packages"
    $Configuration = "Debug"
    $Solution = "$ProjectDir\Solution.sln"
}

task default -depends Build

task Init {
    $script:OutDir = "$ProjectDir\bin\$Configuration"
}

task Clean {
    Push-Location $ProjectDir
    exec -maxRetries 3 { gci . -Include bin,debug,obj,*.orig -Recurse | ri -Recurse -Force }
    Pop-Location
}

task Build -depends Clean, Init {
    Push-Location $ProjectDir
    # & $nuget restore
    exec {
        msbuild $Solution `
                /t:Rebuild `
                /p:Configuration=$Configuration `
                /p:OutDir="$OutDir\" `
                /p:WebProjectOutputDir="$OutDir\Web" `
                /m 
    }
    Pop-Location
}