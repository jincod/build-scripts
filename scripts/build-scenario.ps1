properties {
    $ProjectDir = Resolve-Path ".\.."
    $PackagesDir = "$ProjectDir\packages"
    $nunit = "$ProjectDir\packages\NUnit.ConsoleRunner\tools\nunit3-console.exe"
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

task Tests -depends Init {
    $tests = (Get-ChildItem $OutDir -Recurse -Include *Tests.dll)
    exec { & $nunit $tests --noheader --framework=net-4.5 --work=$OutDir }
}