//
//  String + ConvertHTML.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data,
                                          options: [.documentType : NSAttributedString.DocumentType.html],
                                          documentAttributes: nil)
         } catch{
            return NSAttributedString()
        }
    }
}
