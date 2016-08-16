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
    var mockCenter = MockNotificationCenter()
    var sut: ScreenBrightness!
    
    override func setUp() {
        super.setUp()
        
        self.sut = ScreenBrightness(notificationCenter: self.mockCenter)
    }
    
    func test_init() {
        XCTAssertNotNil(self.sut)
        XCTAssertNotNil(self.sut.notificationCenter)
        XCTAssertTrue(self.sut.border == 0.5)
        XCTAssertTrue(self.sut === self.mockCenter.observer)
    }
    
    func test_onScreenBrightnessDidChange() {
        
        // given
        let center = NSNotificationCenter.defaultCenter()
        self.sut = ScreenBrightness(notificationCenter: center)
     
        var didCall = false
        let delegate = TestDelegate()
        delegate.onDidChange = {
            didCall = true
        }
        
        // when
        self.sut.delegate = delegate
        center.postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
        
        // then
        XCTAssertTrue(didCall)
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
