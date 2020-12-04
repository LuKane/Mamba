//
//  Date+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/4.
//

import Foundation

extension Date {
    
    /// current year[2020]
    /// - Returns: year
    func year() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.year], from: self).year ?? 0
    }
    
    /// current month [12]
    /// - Returns: month
    func month() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.month], from: self).month ?? 0
    }
    
    /// current day [4]
    /// - Returns: day
    func day() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.day], from: self).day ?? 0
    }
    
    /// current hour [12]
    /// - Returns: hour
    func hour() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.hour], from: self).hour ?? 0
    }
    
    /// current min [19]
    /// - Returns: min
    func minute() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.minute], from: self).minute ?? 0
    }
    
    /// current sec [28]
    /// - Returns: sec
    func second() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.second], from: self).second ?? 0
    }
    
    /// current nano sec [282027006]
    /// - Returns: nano sec
    func nanosecond() -> Int {
        return Calendar.current.dateComponents([Calendar.Component.nanosecond], from: self).nanosecond ?? 0
    }
}
