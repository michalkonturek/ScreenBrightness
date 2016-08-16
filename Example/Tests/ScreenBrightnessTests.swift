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
