//
//  String+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/2.
//

import Foundation
import CommonCrypto

extension Double {
    /// rounding of Double . ( 19.556   ===>  19.56  ||  19.544   ===>   19.54)
    /// - Parameter number: number
    /// - Returns: rounding value
    func roundTo(number: Int) -> Double {
        let divisor = pow(10.0,Double(number))
        return (self * divisor).rounded() / divisor
    }
}
extension Float {
    /// rounding of Float . ( 19.556   ===>  19.56  ||  19.544   ===>   19.54)
    /// - Parameter number: number
    /// - Returns: rounding value
    func roundTo(number: Int) -> Float {
        let divisor = pow(10.0,Float(number))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    /// lowercased md5
    /// - Returns: md5 string
    func md5() -> String {
        if let data = cString(using: .utf8) {
            let strLen = CUnsignedInt(lengthOfBytes(using: .utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
            CC_MD5(data, strLen, result)
            let hash = NSMutableString()
            for i in 0..<digestLen {
                hash.appendFormat("%02x", result[i])
            }
            free(result)
            return String(format: hash as String)
        }
        return ""
    }
    
    /// uppercased md5
    /// - Returns: md5 String
    func MD5() -> String {
        return md5().uppercased()
    }
    
    /// unicode
    /// - Returns: unicode string
    func unicode() -> String {
        let temp1 = replacingOccurrences(of: "\\u", with: "\\U")
        let temp2 = temp1.replacingOccurrences(of: "\"", with: "\\\"")
        let temp3 = "\"".appending(temp2).appending("\"")
        let tempData = temp3.data(using: String.Encoding.utf8)
        var result = ""
        do {
           result = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch  {
            
        }
        return result.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
    /// sha1
    /// - Returns: sha1 String
    func sha1() -> String {
        guard isEmpty == false else {
            return ""
        }
        let data = NSData.init(data: self.data(using: .utf8, allowLossyConversion: true)!)
        return data.sha1().hexedString()
    }

    /// sub string to locate
    /// - Parameter to: locate
    /// - Returns: sub string
    func subString(to: Int) -> String {
        var too = to
        if too > count  {
            too = count
        }
        return String(prefix(too))
    }
    
    /// sub String from locate
    /// - Parameter from: locate
    /// - Returns: sub string
    func subString(from: Int) -> String {
        guard from < count else {
            return ""
        }
        let startI  = index(startIndex,offsetBy: from)
        let endI    = endIndex
        return String(self[startI..<endI])
    }
    
    /// sub string from locate to locate
    /// - Parameters:
    ///   - start: locate start
    ///   - end: locate end
    /// - Returns: sub string
    func subString(start: Int, end: Int) -> String {
        if start < end {
            let startI = index(startIndex, offsetBy: start)
            let endI = index(startIndex, offsetBy: end)
            return String(self[startI..<endI])
        }
        return ""
    }
    
    /*****************************************************************************/
    /// insert space to string each four chars [1234 5678 9012 3456]
    /// - Returns: string
    func insertSpaceWhenFourChar() -> String {
        guard isEmpty == false else {
            return self
        }
        guard count > 4 else {
            return self
        }
        var str = replacingOccurrences(of: " ", with: "")
        var last = ""
        while str.count > 0 {
            let subString = str.subString(to: min(str.count, 4))
            last += subString
            if subString.count == 4 {
                last += " "
            }
            str = str.subString(from: min(str.count, 4))
        }
        return last.trimmingCharacters(in: .whitespaces)
    }
    
    /// mask to bankCard num [the first four char **** **** the last four char]
    /// - Returns: mask string
    func stringBankCardNumMask() -> String {
        guard isEmpty == false else {
            return self
        }
        guard count >= 16 else {
            return self
        }
        
        let start = index(startIndex, offsetBy: 4)
        let end   = index(startIndex, offsetBy: count - 4)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return replacingCharacters(in: range, with: "********")
    }
    
    /// mask to ID card num [the first four char **** **** the last four char]
    /// - Returns: mask string
    func stringIdentityCardNumMask() -> String {
        guard isEmpty == false else {
            return ""
        }
        let IdentityReg = "(\\d{14}|\\d{17})(\\d|[xX])$"
        let IdentityTest = NSPredicate.init(format: "SELF MATCHES %@", IdentityReg)
        
        if IdentityTest.evaluate(with: self) == false {
            return self
        }
        return subString(to: 4) + "********" + subString(from: count - 4)
    }
    
    /// mask to user name [赵子龙  ==> *子龙]
    /// - Returns: mask string
    func stringUserNameMask() -> String {
        guard isEmpty == false else {
            return ""
        }
        guard count >= 2 else {
            return self
        }
        let start = index(startIndex, offsetBy: 0)
        let end   = index(startIndex, offsetBy: 1)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return replacingCharacters(in: range, with: "*")
    }
    
    /// mask to phone number [18800004444 ==> 188****4444]
    /// - Returns: mask string
    func stringPhoneNumMask() -> String {
        guard isEmpty == false else {
            return ""
        }
        guard count == 11 else {
            return self
        }
        let start = index(startIndex, offsetBy: 3)
        let end   = index(startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return replacingCharacters(in: range, with: "****")
    }
    
    /// replace string with identification char
    /// - Parameter char: identification char
    /// - Returns: string
    func stringReplacingChar(char: String) -> String {
        guard isEmpty == false else {
            return ""
        }
        return replacingOccurrences(of: char, with: "")
    }
    
    /// auto fill two zero to last string  [19.40 || 19.00 || 19.54]
    /// - Returns: string
    func stringPointDoubleZero() -> String {
        return stringPointZero(zeroNum: 2)
    }
    
    /// auto fill three zero to last string  [19.400 || 19.000 || 19.534 || 19.540]
    /// - Returns: string
    func stringPointTripleZero() -> String {
        return stringPointZero(zeroNum: 3)
    }
    
    /// auto fill number's zero to last string
    /// - Parameter zeroNum: zero count
    /// - Returns: string
    func stringPointZero(zeroNum: Int) -> String {
        
        guard zeroNum > 0 else {
            if contains(".") {
                let arr = components(separatedBy: ".")
                return arr.first!
            }
            return self
        }
        guard isEmpty == false else {
            var zero = "."
            for _ in 0..<zeroNum {
                zero+="0"
            }
            return "0" + zero
        }
        
        var price = self
        if contains(".") {
            let arr = components(separatedBy: ".")
            if arr.count != 2 {
                return price
            }
            let firstPart = arr.first!
            let lastPart  = arr.last!
            if lastPart.count <= zeroNum {
                var zero = lastPart
                for _ in 0..<(zeroNum-lastPart.count) {
                    zero+="0"
                }
                return firstPart + "." + zero
            }else {
                return firstPart + "." + lastPart.subString(to: zeroNum)
            }
        }
        var zero = "."
        for _ in 0..<zeroNum {
            zero+="0"
        }
        price.append(zero)
        return price
    }
    
    /*****************************************************************************/
    
    /// string transform to Data
    /// - Returns: data?
    func stringToData() -> Data? {
        return data(using: .utf8, allowLossyConversion: true)
    }
    
    /// string transform to NSData
    /// - Returns: NSData?
    func stringToNSData() -> NSData? {
        return stringToData() as NSData?
    }
    
}
