//
//  Date+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/4.
//

import Foundation
import UIKit

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
    
    /*****************************************************************************/
    
    /// date from string
    /// - Parameters:
    ///   - dateString: string
    ///   - format: format
    /// - Returns: date
    static func dateFromString(_ dateString: String, format: String) -> Date? {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        return dateFormat.date(from: dateString)
    }
    
    /// date to string
    /// - Parameter format: format
    /// - Returns: string
    func dateToString(format: String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    /// date to Time zone date [the normal date will add eight hour zone : 2000-11-11 12:00:00  ==> 2000-11-11 20:00:00]
    /// - Returns: time zone date
    func dateToTimeZone() -> Date {
        let time = TimeZone.current.secondsFromGMT(for: self)
        return addingTimeInterval(TimeInterval(time))
    }
    
    /*****************************************************************************/
    
    /// is the same year compare to otherDate
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same year
    func isSameYear(otherDate: Date) -> Bool {
        let now   = Calendar.current.dateComponents([ .era, .year], from: self)
        let other = Calendar.current.dateComponents([ .era, .year], from: otherDate)
        if now.era == other.era && now.year == other.year {
            return true
        }
        return false
    }
    
    /// is the same month compare to otherDate [but first is need to compare Year]
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same month
    func isSameMonth(otherDate: Date) -> Bool {
        if isSameYear(otherDate: otherDate) == false {
            return false
        }
        
        let now   = Calendar.current.dateComponents([ .era, .year, .month], from: self)
        let other = Calendar.current.dateComponents([ .era, .year, .month], from: otherDate)
        if now.era == other.era && now.year == other.year && now.month == other.month {
            return true
        }
        return false
    }
    
    /// is the same day compare to otherDate [but first is need to compare Year && Month]
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same day
    func isSameDay(otherDate: Date) -> Bool {
        if isSameMonth(otherDate: otherDate) == false {
            return false
        }
        
        let now   = Calendar.current.dateComponents([ .era, .year, .month, .day], from: self)
        let other = Calendar.current.dateComponents([ .era, .year, .month, .day], from: otherDate)
        if now.era == other.era &&
            now.year == other.year &&
            now.month == other.month &&
            now.day == other.day{
            return true
        }
        return false
    }
    
    /// is the same hour compare to otherDate [but first is need to compare Year && Month && Day]
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same hour
    func isSameHour(otherDate: Date) -> Bool {
        if isSameDay(otherDate: otherDate) == false {
            return false
        }
        let now   = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour], from: self)
        let other = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour], from: otherDate)
        if now.era == other.era &&
            now.year == other.year &&
            now.month == other.month &&
            now.day == other.day &&
            now.hour == other.hour {
            return true
        }
        return false
    }
    
    /// is the same min compare to otherDate [but first is need to compare Year && Month && Day && Hour]
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same min
    func isSameMin(otherDate: Date) -> Bool {
        if isSameHour(otherDate: otherDate) == false {
            return false
        }
        let now   = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour, .minute], from: self)
        let other = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour, .minute], from: otherDate)
        if now.era == other.era &&
            now.year == other.year &&
            now.month == other.month &&
            now.day == other.day &&
            now.hour == other.hour &&
            now.minute == other.minute {
            return true
        }
        return false
    }
    
    /// is the same second compare to otherDate [but first is need to compare Year && Month && Day && Hour && Min]
    /// - Parameter otherDate: otherDate
    /// - Returns: is the same second
    func isSameSecond(otherDate: Date) -> Bool {
        if isSameMin(otherDate: otherDate) == false {
            return false
        }
        let now   = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour, .minute, .second], from: self)
        let other = Calendar.current.dateComponents([ .era, .year, .month, .day, .hour, .minute, .second], from: otherDate)
        if now.era == other.era &&
            now.year == other.year &&
            now.month == other.month &&
            now.day == other.day &&
            now.hour == other.hour &&
            now.minute == other.minute &&
            now.second == other.second {
            return true
        }
        return false
    }
    
    /// is leap year or not
    /// - Returns: is leap year or not
    func isLeapYear() -> Bool {
        let year = self.year()
        if year % 400 == 0 {
            return true
        }
        if year % 100 != 0 && year % 4 == 0 {
            return true
        }
        return false
    }
    
    /*****************************************************************************/
    
    /// adding years from date
    /// - Parameter years: years
    /// - Returns: new date
    func dateAddingYears(years: Int) -> Date? {
        var components = DateComponents.init()
        components.year = years
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// adding months from date
    /// - Parameter months: months
    /// - Returns: new date
    func dateAddingMonths(months: Int) -> Date? {
        var components = DateComponents.init()
        components.month = months
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// adding weeks from date
    /// - Parameter weeks: weeks
    /// - Returns: new date
    func dateAddingWeeks(weeks: Int) -> Date? {
        var components = DateComponents.init()
        components.weekOfYear = weeks
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// adding days from date
    /// - Parameter days: days
    /// - Returns: new date
    func dateAddingDays(days: Int) -> Date {
        let timeInterval = timeIntervalSinceReferenceDate + TimeInterval(24 * 60 * 60 * days)
        return Date.init(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    /// adding hours from date
    /// - Parameter hours: hours
    /// - Returns: new date
    func dateAddingHours(hours: Int) -> Date {
        let timeInterval = timeIntervalSinceReferenceDate + TimeInterval(60 * 60 * hours)
        return Date.init(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    /// add mins from date
    /// - Parameter mins: mins
    /// - Returns: new date
    func dateAddingMin(mins: Int) -> Date {
        let timeInterval = timeIntervalSinceReferenceDate + TimeInterval(60 * mins)
        return Date.init(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    /// adding seconds from date
    /// - Parameter seconds: seconds
    /// - Returns: new date
    func dateAddingSeconds(seconds: Int) -> Date {
        let timeInterval = timeIntervalSinceReferenceDate + TimeInterval(seconds)
        return Date.init(timeIntervalSinceReferenceDate: timeInterval)
    }
    
}
