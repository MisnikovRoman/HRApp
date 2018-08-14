//
//  UIColor + hexString.swift
//  HRApp
//
//  Created by Роман Мисников on 14/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

extension UIColor {
    var hexString:String? {
        
        if let components = self.cgColor.components {
            
            var r, g, b: CGFloat
            
            let numberOfComponents = self.cgColor.numberOfComponents
            
            switch numberOfComponents {
            case 0...1: return nil
            case 2:
                r = components[0]
                g = components[0]
                b = components[0]
            case 3: return nil
            case 4:
                r = components[0]
                g = components[1]
                b = components[2]
            default: return nil
            }
            
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}
