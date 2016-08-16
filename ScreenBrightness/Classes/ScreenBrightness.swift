//
//  ScreenBrightness.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//
//

import Foundation
//import UIKit

public class ScreenBrightness {
    var notificationCenter: NSNotificationCenter
    var border: Float
//    var screen: UIScreen
    
    public init() {
        self.notificationCenter = NSNotificationCenter.defaultCenter()
        self.border = 0.5;
    }
    
    deinit {
        self.notificationCenter.removeObserver(self)
    }
    
    func subscribeToNotifications() {
        let center = self.notificationCenter
        center.addObserver(self,
                           selector: #selector(screenBrightnessDidChange),
                           name: UIScreenBrightnessDidChangeNotification,
                           object: nil)
    }
    
    @objc func screenBrightnessDidChange(notification: NSNotification) {
        
    }

}

//protocol ScreenBrightnessMonitoring {
//    func screenBrightnessDidChangeToLight();
//    func screenBrightnessDidChangeToDark();
//}
