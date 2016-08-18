//
//  ScreenBrightness.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 15/08/2016.
//
//

import Foundation

/***/
public protocol ScreenBrightnessMonitoring: class {
    func screenBrightnessDidChange()
}

/***/
public class ScreenBrightness {
    
    /***/
    public weak var delegate: ScreenBrightnessMonitoring?
    
    /***/
    public var brightness: CGFloat {
        get {
            return screen.brightness
        }
    }
    
    /***/
    public var isLight: Bool {
        get {
            return (self.screen?.brightness > 0.5)
        }
    }
    
    weak var screen: UIScreen!
    var notificationCenter: NSNotificationCenter
    
    /***/
    convenience public init(screen: UIScreen) {
        self.init(screen: screen, notificationCenter: NSNotificationCenter.defaultCenter())
    }
    
    /***/
    public init(screen: UIScreen, notificationCenter: NSNotificationCenter) {
        self.screen = screen
        self.notificationCenter = notificationCenter
        self.subscribeToNotifications()
    }

    deinit {
        self.notificationCenter.removeObserver(self)
    }
}


// MARK: - ScreenBrightnessMonitoring

extension ScreenBrightness: ScreenBrightnessMonitoring {
    
    /***/
    func subscribeToNotifications() {
        let center = self.notificationCenter
        center.addObserver(self,
                           selector: #selector(onScreenBrightnessDidChange),
                           name: UIScreenBrightnessDidChangeNotification,
                           object: nil)
    }
    
    @objc func onScreenBrightnessDidChange() {
        self.screenBrightnessDidChange()
    }
    
    /***/
    public func screenBrightnessDidChange() {
        self.delegate?.screenBrightnessDidChange()
    }
}
