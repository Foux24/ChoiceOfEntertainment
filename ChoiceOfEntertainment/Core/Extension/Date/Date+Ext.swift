//
//  Date+Ext.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 31.12.2022.
//

import Foundation

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
}
