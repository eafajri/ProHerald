//
//  UIColor+Extension.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

extension UIColor {
    private class func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // #0379bf
    class func brandBlue() -> UIColor {
        return hexStringToUIColor(hex: "0379bf")
    }
    
    // #cfebfb
    class func brandBlueLight() -> UIColor {
        return hexStringToUIColor(hex: "cfebfb")
    }

    class func theBackground() -> UIColor {
        return .white
    }
    
    class func textPrimary() -> UIColor {
        return .darkText
    }
    
    class func textSecondary() -> UIColor {
        return .darkGray
    }
    
    class func lineBorder() -> UIColor {
        return .gray
    }
}
