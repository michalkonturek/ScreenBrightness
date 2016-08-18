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
    
    var mockScreen = FakeScreen()
    let center = NSNotificationCenter.defaultCenter()
    
    let delegate = FakeDelegate()
    var didCall = false
    
    override func setUp() {
        super.setUp()
        
        self.delegate.onDidChange = { self.didCall = true }
        
        self.sut = ScreenBrightness(screen: self.mockScreen, notificationCenter: self.center)
        self.sut.delegate = self.delegate
    }
    
    func test_init() {
        
        // when
        let mockCenter = FakeNotificationCenter()
        self.sut = ScreenBrightness(screen: mockScreen, notificationCenter: mockCenter)
        
        // then
        XCTAssertNotNil(self.sut)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertTrue(self.sut === mockCenter.observer)
    }
    
    func test_onScreenBrightnessDidChange_callsDidChangeToLight() {

        var didCallLight = false
        
        // given
        self.delegate.onDidChangeToLight = { didCallLight = true }
        XCTAssertFalse(self.didCall)
        
        // when
        self.mockScreen.brightness = 0.6
        center.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(self.didCall)
        XCTAssertTrue(didCallLight)
    }
    
    func test_onScreenBrightnessDidChange_callsDidChangeToDark() {
        
        var didCallDark = false
        
        // given
        self.delegate.onDidChangeToDark = { didCallDark = true }
        XCTAssertFalse(self.didCall)
        
        // when
        self.mockScreen.brightness = 0.4
        center.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(didCall)
        XCTAssertTrue(didCallDark)
    }
    
}

class FakeDelegate: ScreenBrightnessMonitoring {
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
