//
//  NSDictionary+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/4.
//

import Foundation

extension NSDictionary {
    
    /// dict to json string
    /// - Parameter dict: dict
    /// - Returns: json string
    class func dictionaryToJson(dict: [String: Any]) -> String {
        if !JSONSerialization.isValidJSONObject(dict) {
            return ""
        }
        let data: Data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return jsonString! as String
    }
    
    /// jsonstring to dict
    /// - Parameter jsonString: json string
    /// - Returns: dict
    class func dictionaryWithJsonString(jsonString: String) -> [String: Any] {
        let jsonData: Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        
        if dict != nil {
            return dict as! [String: Any]
        }
        return [String: Any]()
    }
}
