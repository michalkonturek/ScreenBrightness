# ScreenBrightness

[![Version](https://img.shields.io/cocoapods/v/ScreenBrightness.svg)](http://cocoapods.org/pods/ScreenBrightness)
[![Build Status](https://travis-ci.org/michalkonturek/ScreenBrightness.svg?branch=master)](https://travis-ci.org/michalkonturek/ScreenBrightness)
[![Swift](https://img.shields.io/badge/%20compatible-swift%202.2-orange.svg)](http://swift.org)
[![Platform](https://img.shields.io/cocoapods/p/ScreenBrightness.svg)](http://cocoapods.org/pods/ScreenBrightness)
[![License](https://img.shields.io/cocoapods/l/ScreenBrightness.svg)](http://cocoapods.org/pods/ScreenBrightness)
[![Twitter](https://img.shields.io/badge/contact-@MichalKonturek-blue.svg)](http://twitter.com/michalkonturek)


ScreenBrightness allows you to monitor brightness of your device screen without a hassle.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
Alternatively, you could run the demo by executing `pod try ScreenBrightness` in your terminal.

**NB** Screen brigthness of iOS simulators is always 0.5, so make sure you run it on a real device.

![Demo][DEMO]

[DEMO]:https://github.com/michalkonturek/ScreenBrightness/blob/master/demo.gif

## Usage

To start, simply import `ScreenBrightness` to your project

```swift
import ScreenBrightness
```

and initialize `ScreenBrightness` class, set its `delegate`

```swift
let screenBrightness = ScreenBrightness(screen: UIScreen.mainScreen())
screenBrightness.delegate = self
```

and then implement `screenBrightnessDidChange` method to start monitoring screen brightness changes. 

```swift
func screenBrightnessDidChange() {
    print(screenBrightness.brightness)
    print(screenBrightness.isLight)
}
```


## Properties

```swift
public weak var delegate: ScreenBrightnessMonitoring?
```
A delegate that conforms to `ScreenBrightnessMonitoring` protocol.

```swift
public var brightness: CGFloat
```
Returns screen brightness value.

```swift
public var isLight: Bool
```
Returns `true` if `screen brightness` is greater than defined `threshold`.

```swift
public var threshold: Float
```
Determines if brightness is ligt or dark. Default value is 0.5.


## Installation

ScreenBrightness is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ScreenBrightness"
```


## License

ScreenBrightness is available under the MIT license. See the [LICENSE][LICENSE] file for more info.

[LICENSE]:https://github.com/michalkonturek/ScreenBrightness/blob/master/LICENSE


## Credits

Thsis repository is inspired by [ASCScreenBrightnessDetector][DETECTOR] 
by André Schneider. 

[DETECTOR]:https://github.com/schneiderandre/ASCScreenBrightnessDetector
