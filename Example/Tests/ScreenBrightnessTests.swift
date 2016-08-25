//
//  ScreenBrightnessTests.swift
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

import XCTest

@testable import ScreenBrightness

class ScreenBrightnessTests: XCTestCase {
    var sut: ScreenBrightness!
    
    var fakeScreen = FakeScreen()
    let fakeCenter = FakeNotificationCenter()
    let fakeDelegate = FakeDelegate()
    
    var didCall = false
    
    override func setUp() {
        super.setUp()
        
        self.fakeDelegate.onDidChange = { self.didCall = true }
        
        self.sut = ScreenBrightness(screen: self.fakeScreen, notificationCenter: self.fakeCenter)
        self.sut.delegate = self.fakeDelegate
    }
    
    func test_init() {
        XCTAssertNotNil(self.sut)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertTrue(self.sut === self.fakeCenter.observer)
        XCTAssertTrue(self.sut.screen === self.fakeCenter.object)
        XCTAssertEqual(self.sut.threshold, 0.5)
    }
    
    func test_isLight() {
        self.sut.threshold = 0.2
        
        self.fakeScreen.brightness = 0.1
        XCTAssertFalse(self.sut.isLight)
        
        self.fakeScreen.brightness = 0.2
        XCTAssertFalse(self.sut.isLight)
        
        self.fakeScreen.brightness = 0.21
        XCTAssertTrue(self.sut.isLight)
    }
    
    func test_onScreenBrightnessDidChange_didChangeToLight() {
        
        // given
        XCTAssertFalse(self.didCall)
        
        // when
        self.fakeScreen.brightness = 0.6
        self.fakeCenter.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(self.didCall)
        XCTAssertTrue(self.sut.isLight)
        XCTAssertEqual(self.sut.brightness, 0.6)
    }
    
    func test_onScreenBrightnessDidChange_didChangeToDark() {
        
        // given
        XCTAssertFalse(self.didCall)
        
        // when
        self.fakeScreen.brightness = 0.4
        self.fakeCenter.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(self.didCall)
        XCTAssertFalse(self.sut.isLight)
        XCTAssertEqual(self.sut.brightness, 0.4)
    }
    
}

class FakeDelegate: ScreenBrightnessMonitoring {
    var onDidChange: (() -> ())?
    
    internal func screenBrightnessDidChange() {
        self.onDidChange!()
    }
}

class FakeScreen: UIScreen {
    var value: CGFloat = 0
    override var brightness: CGFloat {
        get { return value }
        set {
            value = newValue
        }
    }
}

class FakeNotificationCenter: NSNotificationCenter {
    internal var didRemoveObserver: Bool = false
    internal weak var observer: AnyObject!
    internal weak var object: AnyObject?
    var selector: Selector!
    
    override init () {}
    
    override func addObserver(observer: AnyObject, selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        self.observer = observer
        self.selector = aSelector
        self.object = anObject
    }
    
    override func removeObserver(observer: AnyObject) {
        if self.observer === observer {
            self.didRemoveObserver = true
        }
    }
    
    override func postNotificationName(aName: String, object anObject: AnyObject?) {
        self.observer.performSelector(self.selector)
    }
}
