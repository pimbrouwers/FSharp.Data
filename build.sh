#!/bin/bash
if [ ! -f tools/FAKE/tools/Fake.exe ]; then
  mono tools/NuGet/NuGet.exe install FAKE -OutputDirectory tools -ExcludeVersion -Prerelease
fi

# Used FAKE to build AssemblyInfo file. Some problems with xbuild and FAKE stop doing more.
mono tools/FAKE/tools/FAKE.exe build.fsx AssemblyInfo


# Build the project files explicitly.
xbuild  /Users/Don/GitHub/fsharp/FSharp.Data/src/FSharp.Data.fsproj   /p:Configuration="Release" 

xbuild  /Users/Don/GitHub/fsharp/FSharp.Data/src/FSharp.Data.DesignTime.fsproj   /p:Configuration="Release" 

xbuild  /Users/Don/GitHub/fsharp/FSharp.Data/src/FSharp.Data.Experimental.fsproj   /p:Configuration="Release" 

xbuild  /Users/Don/GitHub/fsharp/FSharp.Data/src/FSharp.Data.Experimental.DesignTime.fsproj   /p:Configuration="Release" 

xbuild  /Users/Don/GitHub/fsharp/FSharp.Data/tests/FSharp.Data.Tests/FSharp.Data.Tests.fsproj   /p:Configuration="Release" 
