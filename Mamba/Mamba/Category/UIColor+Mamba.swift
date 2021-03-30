//
//  UIColor+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/26.
//

import UIKit

extension UIColor {
    
    /// color with rgba
    /// - Parameters:
    ///   - red: red / 255
    ///   - green: green / 255
    ///   - blue: blue / 255
    ///   - alpha: alpha
    /// - Returns: color
    public class func colorRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// color with rgb ,
    /// - Parameters:
    ///   - red: red / 255
    ///   - green: green / 255
    ///   - blue: blue / 255
    /// - Returns: color
    public class func colorRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return colorRGBA(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// color with HexString, Alpha default is 1.0
    /// - Parameter hex: hex
    /// - Returns: color
    public class func colorHex(hex: String) -> UIColor {
        return colorHexAlpha(hex: hex, alpha: 1.0)
    }
    
    /// color with HexString and alpha
    /// - Parameters:
    ///   - hex: hex
    ///   - alpha: alpha
    /// - Returns: color
    public class func colorHexAlpha(hex: String, alpha: CGFloat) -> UIColor {
        
        let hexstr = hex.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "0x", with: "").replacingOccurrences(of: "#", with: "")
        
        guard hexstr.count % 2 == 0 else {
            return .clear
        }
        
        guard hexstr.count >= 6 else {
            return .clear
        }
        
        let index0 = String.Index.init(utf16Offset: 0, in: hexstr)
        let index2 = String.Index.init(utf16Offset: 2, in: hexstr)
        let index4 = String.Index.init(utf16Offset: 4, in: hexstr)
        
        let range1 = index0..<index2
        let range2 = index2..<index4
        let range3 = index4...
        
        let str1 = hexstr[range1]
        let str2 = hexstr[range2]
        let str3 = hexstr[range3]
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: String(str1)).scanHexInt32(&r)
        Scanner.init(string: String(str2)).scanHexInt32(&g)
        Scanner.init(string: String(str3)).scanHexInt32(&b)
        
        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha))
    }
    
    /// get random color
    /// - Returns: color
    public class func colorRandom() -> UIColor {
        let red = (CGFloat)(arc4random() % 256)
        let green = (CGFloat)(arc4random() % 256)
        let blue = (CGFloat)(arc4random() % 256)
        return colorRGB(red: red, green: green, blue: blue)
    }
    
    /*****************************************************************************/
    /// get red value of Current color
    var redValue: CGFloat {
        get {
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            return r
        }
    }
    /// get blue value of Current color
    var blueValue: CGFloat {
        get {
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            return b
        }
    }
    /// get green value of Current color
    var greenValue: CGFloat {
        get {
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 0.0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            return g
        }
    }
    /// get alpha value of Current color
    var alphaValue: CGFloat {
        get {
            return cgColor.alpha
        }
    }
    /*****************************************************************************/
}
