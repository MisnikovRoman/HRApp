//
//  String + UTCAsDate.swift
//  HRApp
//
//  Created by Роман Мисников on 15/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        // Tue Aug 14 17:37:49 UTC 2018 -> "EEE MMM d HH:mm:ss z
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss z yyyy"
        let date = dateFormatter.date(from: self)
        return date
    }
}
