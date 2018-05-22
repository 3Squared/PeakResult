# THRNetwork

This is a Swift microframework providing a super-simple Result type.

The Result type is very simple: it represents either a success — which has an associated value representing the successful result — or a failure — with an associated error. This is perfect to represent operations which can potentially fail.

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

- Using Cocoapods, add `pod 'THRNetwork'` to your Podfile.

- `import THRResult` where necessary.

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

- Inspired by [Asynchronous error handling](http://alisoftware.github.io/swift/async/error/2016/02/06/async-errors/) by Olivier Halligon