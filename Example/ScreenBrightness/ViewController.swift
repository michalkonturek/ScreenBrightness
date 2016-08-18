//
//  ViewController.swift
//  ScreenBrightness
//
//  Created by Michal Konturek on 08/15/2016.
//  Copyright (c) 2016 Michal Konturek. All rights reserved.
//

import UIKit

import ScreenBrightness

class ViewController: UIViewController {
    
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    let screenBrightness = ScreenBrightness(screen: UIScreen.mainScreen())
    let ligthColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
    let darkColor = UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenBrightness.delegate = self
        
        adjustScreen()
        updateBrightnessValueLabel()
    }
    
    func adjustScreen() {
        if screenBrightness.isLight {
            view.backgroundColor = darkColor
            brightnessLabel.textColor = ligthColor
            valueLabel.textColor = ligthColor
        } else {
            view.backgroundColor = ligthColor
            brightnessLabel.textColor = darkColor
            valueLabel.textColor = darkColor
        }
    }
    
    func updateBrightnessValueLabel() {
        valueLabel.text = String(format: "%.8f", screenBrightness.brightness)
    }
}

extension ViewController: ScreenBrightnessMonitoring {
    
    func screenBrightnessDidChange() {
        adjustScreen()
        updateBrightnessValueLabel()
    }
}
