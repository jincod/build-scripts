if(!(Test-Path .nuget\nuget.exe))
{
    if(!(Test-Path .nuget))
    {
        New-Item -type directory .nuget
    }

    Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile .nuget\nuget.exe
}
if(!(Test-Path .\packages\psake))
{
    & .nuget\nuget.exe install Psake -ExcludeVersion -o packages;
}
if(!(Test-Path .\packages\NUnit.Runners))
{
    & .nuget\nuget.exe install NUnit.Runners -ExcludeVersion -o packages;
}