# F# Json

[![NuGet Version](https://img.shields.io/nuget/v/FSharp.Data.Json.svg)](https://www.nuget.org/packages/FSharp.Data.Json)
[![Build Status](https://travis-ci.org/pimbrouwers/FSharp.Data.Json.svg?branch=master)](https://travis-ci.org/pimbrouwers/FSharp.Data.Json)


This is an export of the **core** Json functionality from the amazing [FSharp.Data](https://github.com/fsharp/FSharp.Data) package.

The goal of this fork was to reduce the dependency graph, support .NET Standard 2.0 and offer dead-simple JSON interop, while supporting most existing functionality. HTTP methods for requesting/sending JSON have been removed. My belief was that the responsibility of the library should be restricted to working with JSON, not obtaining it from an HTTP resource. `JsonProvider` has also been removed.

## Parsing JSON documents

The snippet below demonstrates both the usage of the JSON extension methods, and manually parsing values.

```f#
open FSharp.Data.Json
open FSharp.Data.Json.JsonExtensions

type Person =
  {
    Name     : string
    Born     : int
    Siblings : string list
  }

let json =
    JsonValue.Parse(""" 
        { "name": "Tomas", "born": 1985,
        "siblings": [ "Jan", "Alexander" ] } """)

let siblings = 
    match json.TryGetProperty "siblings" with
    | None          -> []
    | Some siblings -> [ for v in siblings -> v.AsString() ]

let person = 
    {
        Name     = json?name.AsString()
        Born     = json?born.AsInteger()    
        Siblings = siblings
    }

// Output { Name = "Tomas"; Born = 1985; Siblings = [ "Jan"; "Alexander" ] }
```


## Find a bug?

There's an [issue](https://github.com/pimbrouwers/FSharp.Data.Json/issues) for that.

## License

Maintained with ♥ by [Pim Brouwers](https://github.com/pimbrouwers) in Toronto, ON. Licensed under [Apache License 2.0](https://github.com/pimbrouwers/FSharp.Data.Json/blob/master/LICENSE).
