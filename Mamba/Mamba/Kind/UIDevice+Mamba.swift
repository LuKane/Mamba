//
//  UIDevice+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/30.
//

import Foundation
import UIKit
import CoreTelephony
import Photos
import AVFoundation

extension UIDevice {
    
    /// device name
    /// - Returns: name
    class func deviceName() -> String {
        return current.name
    }
    
    /// Phone system version
    /// - Returns: system version
    class func deviceSystemVersion() -> String {
        return current.systemVersion
    }
    
    /// App current version
    /// - Returns: app version
    class func deviceAppVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// CarrierName (中国移动 || 中国联通 || "")
    /// - Returns: CarrierName
    class func deviceCarrierName() -> String {
        return CTTelephonyNetworkInfo().subscriberCellularProvider?.carrierName ?? ""
    }
    
    /// stampTime of locate
    /// - Returns: stamp time string
    class func deviceStampTime() -> String {
        let date = Date.init(timeIntervalSinceNow: 0)
        let a: TimeInterval = date.timeIntervalSince1970
        return "\(UInt64(a))"
    }
    
    /// millstampTime of locate
    /// - Returns: stamp time string
    class func deviceStampMillTime() -> String {
        let date = Date.init(timeIntervalSinceNow: 0)
        let a: TimeInterval = date.timeIntervalSince1970
        let mill = CLongLong(round(a*1000))
        return "\(mill)"
    }
    
    /// time description with year month day hour min sec  ("yyyy-MM-dd HH-mm-ss")
    /// - Parameter format: type
    /// - Returns: time description
    class func deviceSystemTime(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    
    /// time description with year month day  ("yyyy-MM-dd ")
    /// - Returns: time description
    class func deviceSystemTimeYMD() -> String {
        return deviceSystemTime("yyyy-MM-dd")
    }
    
    /// time description with year month day hour min sec  ("yyyy-MM-dd HH-mm-ss")
    /// - Returns: time description
    class func deviceSystemTimeYMDHMS() -> String {
        return deviceSystemTime("yyyy-MM-dd HH-mm-ss")
    }
    
    /// device type
    /// - Returns: type
    class func deviceType() -> String {
        // query types from: https://www.theiphonewiki.com/wiki/Models
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting:systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1": return "iPod Touch 5"
        case "iPod7,1": return "iPod Touch 6"
        case "iPhone3,1","iPhone3,2","iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1","iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1","iPhone9,3": return "iPhone 7"
        case "iPhone9,2","iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4": return "iPhone 8"
        case "iPhone10,5","iPhone10,2": return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4": return "iPhone XS Max"
        case "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE (2ed)"
        
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        
        case "iPad2,1", "iPad2,2", "iPad2,3","iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad5,3","iPad5,4": return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1","iPad5,2": return "iPad Mini 4"
        case "iPad6,7","iPad6,8": return "iPad Pro"
        case "AppleTV5,3": return "Apple TV"
        case "i386","x86_64": return "Simulator"
        default: return identifier
        }
    }
    
    /// device >= iPhoneX
    /// - Returns: has or not
    class func deviceHasFringe() -> Bool {
        let type = deviceType()
        if type == "iPhone X" || type == "iPhone XS" || type == "iPhone XS Max" || type == "iPhone XR" || type == "iPhone 11" || type == "iPhone 11 Pro" || type == "iPhone 11 Pro Max" || type == "iPhone 12 mini" || type == "iPhone 12" || type == "iPhone 12 Pro" || type == "iPhone 12 Pro Max" {
            return true
        }
        return false
    }
    
    /// transform timeStamp to time string
    /// - Parameters:
    ///   - timeStamp: timestamp
    ///   - dateFormat: dateformat
    /// - Returns: time string
    class func deviceTransformToString(_ timeStamp: String, dateFormat: String) -> String {
        guard timeStamp.count < 10 else {
            return ""
        }
        var t: TimeInterval?
        if timeStamp.count == 10 {
            t = Double(timeStamp)!
        }else {
            t = TimeInterval(Double(timeStamp)! / 1000.0)
        }
        
        let date: Date = Date(timeIntervalSince1970: t!)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    /********************************** * == Phone Call == * ****************************************/
    
    /// phone call
    /// - Parameters:
    ///   - phone: phone
    ///   - callBack: callback
    /// - Returns: void
    class func devicePhoneCall(phone: String, callBack: ((Bool)->())?) -> Void{
        guard !phone.isEmpty else {
            return
        }
        if #available(iOS 11.2, *) {
            let url = URL.init(string: "telprompt://" + phone)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { (k: Bool) in
                    if callBack != nil {
                        callBack!(k)
                    }
                }
            }
        }else if #available(iOS 10.0, *) {
            let alertVc = UIAlertController(title: nil, message: phone, preferredStyle: .alert)
            let cancelAct = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
                
            }
            let sureAct = UIAlertAction.init(title: "确定", style: .default) { (action) in
                
                let url = URL.init(string: "telprompt://" + phone)!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (k: Bool) in
                        if callBack != nil {
                            callBack!(k)
                        }
                    })
                }
            }
            alertVc.addAction(cancelAct)
            alertVc.addAction(sureAct)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertVc, animated: true, completion: {
                
            })
        }
    }
    
    /// Jump to setting
    /// - Returns: void
    class func deviceJumpToSetting() -> Void {
        let setting: URL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(setting
        , options: [:]) { (k) in
            
        }
    }
    
    /********************************** * == Device Auth == * ****************************************/
    
    /// device camera Auth
    /// - Parameter callBack: callback
    /// - Returns: void
    class func deviceCameraAuth(callBack: @escaping(Bool)->()) -> Void {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted {
            callBack(false)
        } else if authStatus == .denied {
            callBack(false)
        } else if authStatus == .authorized {
            callBack(true)
        } else if authStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (k: Bool) in
                if k == true {
                    DispatchQueue.main.async(execute: {
                        callBack(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        callBack(false)
                    })
                }
            }
        }
    }
    
    /// device album Auth
    /// - Parameter callBack: callback
    /// - Returns: void
    class func deviceAlbumAuth(callBack: @escaping(Bool)->()) -> Void {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .restricted {
            callBack(false)
        } else if status == .denied {
            callBack(false)
        } else if status == .authorized {
            callBack(true)
        } else if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (k: PHAuthorizationStatus) in
                if k == PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async(execute: {
                        callBack(true)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        callBack(false)
                    })
                }
            }
        }
    }
}
