var target = Argument("target", "Default");
var configuration = Argument("configuration", "Release");
var outputDir = "./artifacts/";
var solutionPath = System.IO.Directory.GetFiles(".", "*.sln", SearchOption.AllDirectories).First();

Task("Clean")
  .Does(() => {
    if (DirectoryExists(outputDir))
    {
      var deleteDirectorySettings = new DeleteDirectorySettings
      {
        Recursive = true
      };
      DeleteDirectory(outputDir, deleteDirectorySettings);
    }
    CreateDirectory(outputDir);
  });

Task("Build")
  .IsDependentOn("Clean")
  .Does(() => {
    var settings =  new DotNetCoreBuildSettings
    {
      Configuration = configuration
    };
    DotNetCoreBuild(solutionPath, settings);
  });

Task("Pack")
  .IsDependentOn("Clean")
  .Does(() => {
    var settings = new DotNetCorePackSettings
    {
      Configuration = configuration,
      OutputDirectory = outputDir
    };

    DotNetCorePack("./src/*", settings);
  });

Task("Publish")
  .IsDependentOn("Pack")
  .Does(() => {
    var package = System.IO.Directory.GetFiles(outputDir, "*.nupkg", SearchOption.AllDirectories).First();

    var settings = new NuGetPushSettings
    {
      Source = "https://www.nuget.org/api/v2/package",
      ApiKey = EnvironmentVariable("API_KEY")
    };
    NuGetPush(package, settings);
  });

Task("Default")
  .IsDependentOn("Build");

RunTarget(target);