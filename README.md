# F# JsonValue

This is an export of the **core** Json functionality from the amazing [FSharp.Data](https://github.com/fsharp/FSharp.Data) package.

The goal of this fork was to reduce the dependency graph, support .NET Standard 2.0 and offer dead-simple JSON interop, while supporting most existing functionality. HTTP methods for requesting/sending JSON have been removed. My belief was that the responsibility of the library should be restricted to working with JSON, not obtaining it from an HTTP resource. `JsonProvider` has also been removed.

> The documentation below, has been exported from: [http://fsharp.github.io/FSharp.Data/library/JsonValue.html](http://fsharp.github.io/FSharp.Data/library/JsonValue.html)

## Loading JSON documents

To load a sample JSON document, we first need to reference the `FSharp.Data.dll` library
(when using F# Interactive) or to add reference to a project. 

```f#
open FSharp.Data.Json

let info =
  JsonValue.Parse(""" 
    { "name": "Tomas", "born": 1985,
      "siblings": [ "Jan", "Alexander" ] } """)
```

## Using JSON extensions

We do not cover this technique in this introduction. Instead, we look at a number
of extensions that become available after opening the `FSharp.Data.JsonExtensions` 
namespace. Once opened, we can write:
 * `value.AsBoolean()` returns the value as boolean if it is either `true` or `false`.
 * `value.AsInteger()` returns the value as integer if it is numeric and can be
   converted to an integer; `value.AsInteger64()`, `value.AsDecimal()` and
   `value.AsFloat()` behave similarly.
 * `value.AsString()` returns the value as a string.
 * `value.AsDateTime()` parses the string as a `DateTime` value using either the
    [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) format, or using the 
    `\/Date(...)\/` JSON format containing number of milliseconds since 1/1/1970.
 * `value.AsDateTimeOffset()` parses the string as a `DateTimeOffset` value using either the
    [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) format, or using the 
    `\/Date(...[+/-]offset)\/` JSON format containing number of milliseconds since 1/1/1970, 
    [+/-] the 4 digit offset. Example- `\/Date(1231456+1000)\/`.
 * `value.AsTimeSpan()` parses the string as a `TimeSpan` value.
 * `value.AsGuid()` parses the string as a `Guid` value.
 * `value?child` uses the dynamic operator to obtain a record member named `child`;
    alternatively, you can also use `value.GetProperty(child)` or an indexer
    `value.[child]`.
 * `value.TryGetProperty(child)` can be used to safely obtain a record member 
    (if the member is missing or the value is not a record then, `TryGetProperty` 
    returns `None`).
 * `[ for v in value -> v ]` treats `value` as a collection and iterates over it;
   alternatively, it is possible to obtain all elements as an array using 
   `value.AsArray()`.
 * `value.Properties()` returns a list of all properties of a record node.
 * `value.InnerText()` concatenates all text or text in an array 
   (representing e.g. multi-line string).
Methods that may need to parse a numeric value or date (such as `AsFloat` and
`AsDateTime`) receive an optional culture parameter.
The following example shows how to process the sample JSON value:

```f#
open FSharp.Data.Json.JsonExtensions

// Print name and birth year
let n = info?name
printfn "%s (%d)" (info?name.AsString()) (info?born.AsInteger())

// Print names of all siblings
for sib in info?siblings do
  printfn "%s" (sib.AsString())
```


## Find a bug?

There's an [issue](https://github.com/pimbrouwers/FSharp.Data.JsonValue/issues) for that.

## License

Maintained with ♥ by [Pim Brouwers](https://github.com/pimbrouwers) in Toronto, ON. Licensed under [Apache License 2.0](https://github.com/pimbrouwers/FSharp.Data.JsonValue/blob/master/LICENSE).
