//
//  ScreenBrightness.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//
//

import Foundation
import UIKit

public class ScreenBrightness {
    var notificationCenter: NSNotificationCenter
    
    public init() {
        self.notificationCenter = NSNotificationCenter.defaultCenter()
    }
    
    deinit {
        self.notificationCenter.removeObserver(self)
    }
}