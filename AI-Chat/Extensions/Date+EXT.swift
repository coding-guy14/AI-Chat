//
//  Date+EXT.swift
//  AI-Chat
//
//  Created by Soham Divekar on 15/12/2024.
//

import Foundation

extension Date {
    
    func addingTimeInterval(minutes: Int = 0, hours: Int = 0, days: Int = 0) -> Date {
        let minuteInterval = TimeInterval(minutes * 60)
        let hourInterval = TimeInterval(hours * 60 * 60)
        let dayInterval = TimeInterval(days * 60 * 60 * 24)
        return self.addingTimeInterval(minuteInterval + hourInterval + dayInterval)
    }
}
