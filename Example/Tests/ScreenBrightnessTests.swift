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
    var mockScreen = MockScreen()
    var mockCenter = MockNotificationCenter()
    var sut: ScreenBrightness!
    
    func test_init() {
        self.sut = ScreenBrightness(screen: mockScreen, notificationCenter: self.mockCenter)
        
        XCTAssertNotNil(self.sut)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertTrue(self.sut === self.mockCenter.observer)
    }
    
    func test_onScreenBrightnessDidChange() {

        var didCall = false
        var didCallDark = false
        var didCallLight = false
        
        let center = NSNotificationCenter.defaultCenter()
        self.sut = ScreenBrightness(screen: self.mockScreen, notificationCenter: center)
        
        // given
        let delegate = TestDelegate()
        self.sut.delegate = delegate
        
        delegate.onDidChange = { didCall = true }
        delegate.onDidChangeToDark = { didCallDark = true }
        delegate.onDidChangeToLight = { didCallLight = true }
        
        // when
        self.mockScreen.brightness = 0.4
        center.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(didCall)
        XCTAssertTrue(didCallDark)

        // when
        self.mockScreen.brightness = 0.6
        center.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(didCall)
        XCTAssertTrue(didCallLight)
    }
    
}

class TestDelegate: ScreenBrightnessMonitoring {
    var onDidChange: (() -> ())?
    var onDidChangeToDark: (() -> ())?
    var onDidChangeToLight: (() -> ())?
    
    internal func screenBrightnessDidChange() {
        self.onDidChange!()
    }
    
    internal func screenBrightnessDidChangeToDark() {
        self.onDidChangeToDark!()
    }
    
    internal func screenBrightnessDidChangeToLight() {
        self.onDidChangeToLight!()
    }
}

class MockScreen: UIScreen {
    var value: CGFloat = 0
    override var brightness: CGFloat {
        get { return value }
        set {
            value = newValue
        }
    }
}

class MockNotificationCenter: NSNotificationCenter {
    internal weak var observer: AnyObject!
    internal var didRemoveObserver: Bool = false
    
    override init () {}
    
    override func addObserver(observer: AnyObject, selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        self.observer = observer
    }
    
    override func removeObserver(observer: AnyObject) {
        if self.observer === observer {
            self.didRemoveObserver = true
        }
    }
}
