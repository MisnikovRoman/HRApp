//
//  Date + PrettyString.swift
//  HRApp
//
//  Created by Роман Мисников on 15/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

extension Date {
    
    func stringPrettyFormat() -> String {
        // seconds from now
        var seconds = Int(self.timeIntervalSinceNow * -1)
        let fullDays = seconds / 86400
        seconds %= 86400
        let fullHours = seconds / 3600
        seconds %= 3600
        let fullMinutes = seconds / 60
        seconds %= 60
        
        if fullDays != 0 {
            return "\(fullDays) day" + (fullDays == 1 ? " ago" : "s ago")
        } else if fullHours != 0 {
            return "\(fullHours) hour" + (fullHours == 1 ? " ago" : "s ago")
        } else if fullMinutes != 0 {
            return "\(fullMinutes) minute" + (fullMinutes == 1 ? " ago" : "s ago")
        } else {
            return "\(seconds) second" + (seconds == 1 ? " ago" : "s ago")
        }
    }
}

