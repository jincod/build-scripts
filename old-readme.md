## About

Scripts for build C# projects using [Psake](https://github.com/psake/psake). Compatibility with [TeamCity](http://www.jetbrains.com/teamcity/).

## Setup

Set your solution name in *scripts\build-scenario.ps1*:

```
properties {
    $Solution = "$ProjectDir\Solution.sln"
}
```

## Usage

Build all:

```
build.cmd
```

Only clean:

```
build.cmd clean
```