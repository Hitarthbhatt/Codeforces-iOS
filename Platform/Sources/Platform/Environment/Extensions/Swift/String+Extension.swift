//
//  String+Extension.swift
//  Environment
//
//  Created by Ankit Panchotiya on 18/01/25.
//

import SwiftUI

public extension String {
    func asDictionary() -> [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}

// MARK: - Date String Methods.
public extension String {
    func toDate(
        _ format: Date.DateFormat,
        _ locale: Locale = .current,
        _ timeZone: TimeZone = .current
    ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone

        return dateFormatter.date(from: self)
    }

    /// Converts the current date string from one format to another format.
    /// - Parameters:
    ///   - fromFormat: The format of the current date string.
    ///   - toFormat: The desired format of the date string.
    /// - Returns: A string in the new format if conversion is successful; otherwise, `nil`.
    func convertDateFormat(
        from fromFormat: Date.DateFormat,
        to toFormat: Date.DateFormat,
        _ locale: Locale = .current,
        _ timeZone: TimeZone = .current
    ) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone

        guard let date = dateFormatter.date(from: self) else { return nil }

        dateFormatter.dateFormat = toFormat.rawValue
        return dateFormatter.string(from: date)
    }

    func isPastDate(
        format: Date.DateFormat,
        _ locale: Locale = .current,
        _ timeZone: TimeZone = .current
    ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone

        guard let date = dateFormatter.date(from: self) else {
            return false
        }

        return date < Date()
    }

    func toDay(format: Date.DateFormat) -> String? {
        return extractDateComponent(format: format, toFormat: .dayNumber)
    }

    func toMonth(format: Date.DateFormat, fullMonth: Bool = true) -> String? {
        return extractDateComponent(
            format: format,
            toFormat: fullMonth ? .monthFullName : .monthNumber
        )
    }

    func toYear(format: Date.DateFormat) -> String? {
        return extractDateComponent(format: format, toFormat: .yearNumber)
    }

    private func extractDateComponent(format: Date.DateFormat, toFormat: Date.DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: self) else { return nil }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = toFormat.rawValue
        return outputFormatter.string(from: date)
    }
}

// MARK: - Numeric String Extension
public extension String {
    func toCurrencyFormat(
        locale: Locale = Locale.current,
        maximumFractionDigits: Int = 0,
        minimumFractionDigits: Int = 0
    ) -> String? {
        guard let value = Double(self) else { return nil }

        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.numberStyle = .currency
        formatter.locale = locale

        return formatter.string(from: NSNumber(value: value))
    }
}

// MARK: - For OTP
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String { // swiftlint:disable:this identifier_name
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String { // swiftlint:disable:this identifier_name
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

// MARK: - Image to base64 String
extension String {

    public func encodeImageToBase64(image: UIImage?) -> String {
        guard let scannedImage = image else {
            return ""
        }
        if let imageData = scannedImage.jpegData(compressionQuality: 0.5) {
            return imageData.base64EncodedString()
        }
        return ""
    }
}

// MARK: - Get day mode string
extension String {

    static public var currentGreeting: String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return "Good Morning 🌤️"
        case 12..<17:
            return "Good Afternoon ☀️"
        case 17..<21:
            return "Good Evening 🌇"
        default:
            return "Good Night 🌙"
        }
    }
}
