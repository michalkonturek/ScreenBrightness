//
//  ScreenBrightness.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//
//

import Foundation

public protocol ScreenBrightnessMonitoring: class {
    func screenBrightnessDidChange()
    func screenBrightnessDidChangeToDark();
    func screenBrightnessDidChangeToLight();
}

public class ScreenBrightness {
    public weak var delegate: ScreenBrightnessMonitoring?
    
    weak var screen: UIScreen?
    var notificationCenter: NSNotificationCenter
    
    convenience public init(screen: UIScreen) {
        self.init(screen: screen, notificationCenter: NSNotificationCenter.defaultCenter())
    }
    
    public init(screen: UIScreen, notificationCenter: NSNotificationCenter) {
        self.screen = screen
        self.notificationCenter = notificationCenter
        self.subscribeToNotifications()
    }
    
    func subscribeToNotifications() {
        let center = self.notificationCenter
        center.addObserver(self,
                           selector: #selector(onScreenBrightnessDidChange),
                           name: UIScreenBrightnessDidChangeNotification,
                           object: nil)
    }
    
    deinit {
        self.notificationCenter.removeObserver(self)
    }
    
    @objc func onScreenBrightnessDidChange() {
        self.screenBrightnessDidChange()
        
        NSLog("\(self.screen?.brightness)")
        if self.screen?.brightness > 0.5 {
            self.screenBrightnessDidChangeToLight()
        } else {
            self.screenBrightnessDidChangeToDark()
        }
    }

}


// MARK: - ScreenBrightnessMonitoring

extension ScreenBrightness: ScreenBrightnessMonitoring {
    
    public func screenBrightnessDidChange() {
        self.delegate?.screenBrightnessDidChange()
    }
    
    public func screenBrightnessDidChangeToDark() {
        self.delegate?.screenBrightnessDidChangeToDark()
    }
    
    public func screenBrightnessDidChangeToLight() {
        self.delegate?.screenBrightnessDidChangeToLight()
    }
}
