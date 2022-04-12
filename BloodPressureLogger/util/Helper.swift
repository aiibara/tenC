//
//  Helper.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import Foundation


struct Helper {
    static func formatDate(date: Date, format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: date as Date)
    }
    
     static func formatDateAdv(date:Date, format: String = "dd MMM yy") -> String {
         let cal = Calendar.current
         if cal.isDateInToday(date) {
             return "Today"
         } else if cal.isDateInYesterday(date) {
             return "Yesterday"
         } else {
             return Helper.formatDate(date:date, format: format)
         }
    }
    
    static func getStartDateof(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func getEndDateof(date: Date) -> Date {
        let startDate = getStartDateof(date: date)
        return Calendar.current.date(byAdding: .second, value: 60*60*24-1, to: startDate)!
    }
}
