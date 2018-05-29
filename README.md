
![Peak Result](result.png "Peak Result")

Result is a Swift microframework providing a simple `Result` type. It is part of the [Peak Framework](#peak-framework).


The Result type is very simple: it represents either success, with an associated value representing the successful result; or a failure, with an associated error. This is perfect to represent operations which can potentially fail.

## Examples

```swift
// Both are Result<String> even though one has a string and the other contains an error
let niceResult = Result { return "Hello!" }
let throwingResult = Result { throw TestError.justATest }
```

### Unwrapping with `switch-case`
```swift
func throwingMethod() -> String throws { ... }
let result = Result { throwingMethod() }

switch result {
case .success(let value):
    print(value) // value is String
case .failure(let error):
    print(error.localizedDescription) // handle any error
}

```

### Unwrapping with `do-try`
```swift
func throwingMethod() -> String throws { ... }
let result = Result { throwingMethod() }

do {
    let value = try result.resolve() // value is String
} catch {
    print(error.localizedDescription) // handle any error
}

```

Please see the included tests for further examples.

## Getting Started

### Installing

- Using Cocoapods, add `pod 'PeakResult'` to your Podfile.

- `import PeakResult` where necessary.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

- Inspired by [Asynchronous error handling](http://alisoftware.github.io/swift/async/error/2016/02/06/async-errors/) by Olivier Halligon

# Peak Framework

The Peak Framework is a collection of open-source microframeworks created by the team at [3Squared](https://github.com/3squared), named for the [Peak District](https://en.wikipedia.org/wiki/Peak_District). It is made up of:

|Name|Description|
|:--|:--|
|[PeakOperation](https://github.com/3squared/PeakOperation)|Provides enhancement and conveniences to `Operation`, making use of the `Result` type.|
|[PeakNetwork](https://github.com/3squared/PeakNetwork)|A networking framework built on top of `Session` using PeakOperation, leveraging the power of `Codable`.|
|[PeakCoreData](https://github.com/3squared/PeakCoreData)|A collection of helpers and convenience methods for creating and observing ManagedObjects, including performant import operations using `PeakOperation`.|

