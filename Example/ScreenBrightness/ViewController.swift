//
//  ViewController.swift
//  ScreenBrightness
//
//  Copyright (c) 2016 Michal Konturek <michal.konturek@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

import ScreenBrightness

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
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
        
        var style = UIStatusBarStyle.Default
        
        if screenBrightness.isLight {
            view.backgroundColor = ligthColor
            brightnessLabel.textColor = darkColor
            valueLabel.textColor = darkColor
            imageView.image = UIImage(named: "sun")
            imageView.tintColor = darkColor
        } else {
            view.backgroundColor = darkColor
            brightnessLabel.textColor = ligthColor
            valueLabel.textColor = ligthColor
            imageView.image = UIImage(named: "moon")
            imageView.tintColor = ligthColor
            style = .LightContent
        }
        
        UIApplication.sharedApplication().statusBarStyle = style
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
