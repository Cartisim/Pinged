//
//  DateFormatter+Extension.swift
//  Cartisim
//
//  Created by Cole M on 9/2/20.
//  Copyright © 2020 Cole M. All rights reserved.
//
import Cocoa

extension DateFormatter {
    func getFormattedDate(currentFormat: String, newFormat: String, dateString: String) -> String {
         let dateFormatter = self
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        dateFormatter.dateFormat = currentFormat

        let oldDate = dateFormatter.date(from: dateString)

        let converToNewFormat = self
        converToNewFormat.dateFormat = newFormat

        return converToNewFormat.string(from: oldDate!)
     }
}
