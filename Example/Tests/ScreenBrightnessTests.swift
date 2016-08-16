//
//  ScreenBrightnessTests.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//  Copyright © 2016 Michal Konturek. All rights reserved.
//

import XCTest

import ScreenBrightness

class ScreenBrightnessTests: XCTestCase {
    var sut = ScreenBrightness()
    
    override func setUp() {
        super.setUp()
    }
    
    func test_init() {
        XCTAssertNotNil(self.sut)
    }
}
