//
//  ScreenBrightness.swift
//  ScreenBrightness
//
//  Copyright (c) 2016 Michal Konturek <michal.konturek@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/**
 `ScreenBrightness` delegate.

 A class with ability to receive changes in screen brightness.
 */
public protocol ScreenBrightnessMonitoring: class {

    /**
     Called when a `brightness` of device screen changes.
     */
    func screenBrightnessDidChange()
}

/**
 A `class` that detects changes in screen brightness.
 */
public class ScreenBrightness {

    /**
     A delegate that conforms to `ScreenBrightnessMonitoring` protocol.
     */
    public weak var delegate: ScreenBrightnessMonitoring?

    /**
     Returns screen brightness value.
     - important: Returned value is between 0 and 1.
     */
    public var brightness: CGFloat {
        get {
            return screen.brightness
        }
    }

    /**
     Returns `true` if `screen brightness` is greater than `0.5`.
     */
    public var isLight: Bool {
        get {
            return (self.screen?.brightness > 0.5)
        }
    }

    weak var screen: UIScreen!
    var notificationCenter: NSNotificationCenter

    /**
     Convenience initializer. Instantiates `ScreenBrightness` object.

     - important: Initialises with default `NSNotificationCenter`.

     - parameter screen: object representing the device's screen.
     */
    convenience public init(screen: UIScreen) {
        self.init(screen: screen, notificationCenter: NSNotificationCenter.defaultCenter())
    }

    /**
     Instantiates `ScreenBrightness` object.

     - parameter screen: object representing the device's screen.
     - parameter notificationCenter: object representing `NSNotificationCenter`.
     */
    public init(screen: UIScreen, notificationCenter: NSNotificationCenter) {
        self.screen = screen
        self.notificationCenter = notificationCenter
        self.subscribeToNotifications()
    }

    deinit {
        self.notificationCenter.removeObserver(self)
    }
}


// MARK: - ScreenBrightnessMonitoring

extension ScreenBrightness: ScreenBrightnessMonitoring {

    func subscribeToNotifications() {
        let center = self.notificationCenter
        center.addObserver(self,
                           selector: #selector(onScreenBrightnessDidChange),
                           name: UIScreenBrightnessDidChangeNotification,
                           object: nil)
    }

    @objc func onScreenBrightnessDidChange() {
        self.screenBrightnessDidChange()
    }

    /**
     Called when a `brightness` of device screen changes.
     */
    public func screenBrightnessDidChange() {
        self.delegate?.screenBrightnessDidChange()
    }
}
