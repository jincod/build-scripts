if(!(Test-Path .nuget))
{
    New-Item -type directory .nuget
    if (!(Get-Command "Invoke-WebRequest" -CommandType Cmdlet -errorAction SilentlyContinue))
    {
        "Invoke-WebRequest not found. Douwnload and copy nuget.exe (http://www.nuget.org/nuget.exe) to .nuget folder"
        exit 1;
    }
    else
    {
        Invoke-WebRequest http://www.nuget.org/nuget.exe -OutFile .nuget\nuget.exe
    }
}
if(!(Test-Path .\packages\psake))
{
    & .nuget\nuget.exe install Psake  -ExcludeVersion -o packages;
}
Import-Module '.\packages\psake\tools\psake.psm1';
invoke-psake .\scripts\build-scenario.ps1 $args;
if($psake.build_success -eq $false)
{
    write-host "ERROR!!!" -fore RED; 
    $exitCode = 1;
}
else
{
    write-host "Success!" -fore GREEN;
    $exitCode = 0;
}
remove-module psake;
exit $exitCode;