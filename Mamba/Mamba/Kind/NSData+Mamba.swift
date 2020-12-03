//
//  NSData+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/2.
//

import Foundation
import CommonCrypto

extension NSData {
    
    /// SHA1
    /// - Returns: data
    func sha1() -> NSData{
        let result = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_SHA1(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
    
    /// hexString
    /// - Returns: string
    func hexedString() -> String {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start: unsafePointer, count: length){
            string = string + (NSString(format: "%02x", Int(i)) as String)
        }
        return string
    }
    
    /// data transform to string
    /// - Returns: string
    func dataToString() -> String {
        return NSString(bytes: bytes, length: length, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    /// data to base64
    /// - Returns: string
    func dataToBase64String() -> String {
        return self.base64EncodedString(options: .init(rawValue: 0))
    }
    
    /// data from base64
    /// - Parameter base64EncodedString: base64
    /// - Returns: string
    func dataFromBase64String(base64EncodedString: String) -> NSData? {
        return NSData(base64Encoded: base64EncodedString, options: .init(rawValue: 0))
    }
}
