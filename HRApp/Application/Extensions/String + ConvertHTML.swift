//
//  String + ConvertHTML.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

extension String{
    func htmlAttributed(fontName: String, size: Float, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString ?? "000000") !important;" +
                "font-family: \(fontName), -apple-system, Helvetica !important;" +
            "}</style> \(self)"
            
            print("CSS:", htmlCSSString)
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else { return nil }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
