//
//  ScreenBrightnessTests.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//  Copyright © 2016 Michal Konturek. All rights reserved.
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
    var selector: Selector!
    
    override init () {}
    
    override func addObserver(observer: AnyObject, selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        self.observer = observer
        self.selector = aSelector
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
