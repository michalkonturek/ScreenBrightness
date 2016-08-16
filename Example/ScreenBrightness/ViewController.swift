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
    var screenBrightness = ScreenBrightness()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().postNotificationName(UIScreenBrightnessDidChangeNotification, object: nil)
    }
}

