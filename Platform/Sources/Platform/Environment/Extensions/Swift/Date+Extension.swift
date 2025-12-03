//
//  Date+Extension.swift

import SwiftUI

public extension Date {
    enum DateFormat: String {
        case dateMonthYear = "dd-MM-yy"
        case dashDateShortMonthYear = "dd-MMM-yyyy"
        case dashYearMonthDateWithFullTime = "yyyy-MM-dd HH:mm:ss"
        case subscriptionDateTime = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case dateMonthShortNameYear = "dd MMM. yyyy"
        case soloChatList = "MMM dd, yyyy HH:mm a"
        case yearMonthDataShortName = "yyyy-MM-dd"
        case dayNumber = "dd"
        case monthNumber = "MM"
        case monthFullName = "MMMM"
        case yearNumber = "yyyy"
    }
}

public extension Date {
    var month: Int { Calendar.current.component(.month, from: self) }
    var day: Int { Calendar.current.component(.day, from: self) }
    var year: Int { Calendar.current.component(.year, from: self) }
    
    func toString(using format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    static func fromTimestamp(
        _ timestamp: TimeInterval,
        format: DateFormat = .yearMonthDataShortName
    ) -> String {
        let date = Date(timeIntervalSince1970: timestamp/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    func convertTimestampToDate(
        _ timestampString: String,
        format: DateFormat = .yearMonthDataShortName
    ) -> String? {
        guard let timeInterval = TimeInterval(timestampString) else { return nil }

        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    func toDay() -> String? {
        return toString(using: .dayNumber)
    }
    
    func toMonth(fullMonth: Bool = false) -> String? {
        return toString(using: fullMonth ? .monthFullName : .monthNumber)
    }
    
    func toYear() -> String? {
        return toString(using: .yearNumber)
    }
}

public extension Date {
    func currentTimeMillis() -> Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
    
    func getCurrentMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        let month = formatter.string(from: Date())
        return month
    }
}

// MARK: - Random Date helpers

public extension Date {

    /// Random date within the last `daysBack` days (default 30), up to "now".
    static func randomRecent(daysBack: Int = 30) -> Date {
        precondition(daysBack > 0)
        let now = Date()
        let earliest = Calendar.current.date(byAdding: .day, value: -daysBack, to: now)!
        return Date.random(in: earliest...now)
    }

    /// Random date within a closed range.
    static func random(in range: ClosedRange<Date>) -> Date {
        let start = range.lowerBound.timeIntervalSince1970
        let end   = range.upperBound.timeIntervalSince1970
        return Date(timeIntervalSince1970: TimeInterval.random(in: start...end))
    }
}
