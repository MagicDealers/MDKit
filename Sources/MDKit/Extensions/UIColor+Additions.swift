//
//  UIColor+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 30/11/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: String, alpha: CGFloat = 1) {
        
        let hexString: String = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        
        var rgbValue: UInt64 = 0
        
        let scanner = Scanner(string: hexString)
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0xFF00) >> 8
        let b = rgbValue & 0xFF
        
        self.init(red: CGFloat(r) / 0xFF,
                  green: CGFloat(g) / 0xFF,
                  blue: CGFloat(b) / 0xFF,
                  alpha: alpha
        )
    }
}
