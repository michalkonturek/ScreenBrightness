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
    
    convenience public init() {
        self.init(notificationCenter: NSNotificationCenter.defaultCenter())
    }
    
    public init(notificationCenter: NSNotificationCenter) {
        self.notificationCenter = notificationCenter
        self.border = 0.5;
        self.subscribeToNotifications()
    }
    
    func subscribeToNotifications() {
        let center = self.notificationCenter
        center.addObserver(self,
                           selector: #selector(screenBrightnessDidChange),
                           name: UIScreenBrightnessDidChangeNotification,
                           object: nil)
    }
    
    deinit {
        self.notificationCenter.removeObserver(self)
    }
    
    @objc func screenBrightnessDidChange(notification: NSNotification) {
        
    }

}

//protocol ScreenBrightnessMonitoring {
//    func screenBrightnessDidChangeToLight();
//    func screenBrightnessDidChangeToDark();
//}
