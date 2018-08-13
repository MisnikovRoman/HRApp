//
//  Vacancy.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class Vacancy: Decodable {
    let id, createdAt, title, location, type: String
    let description, howToApply, company: String
    let companyURL, companyLogo: String?
    let url: String
    
    func printDescription() {
        var text = "=========================\n"
        text += "ID: \(id)\n"
        text += "Created at: \(createdAt)\n"
        text += "Title: \(title)\n"
        text += "Location: \(location)\n"
        text += "Type: \(type)\n"
        //text += "Description: \(description)\n"
        text += "How To Apply: \(howToApply)\n"
        text += "Company: \(company)\n"
        text += "Company URL: \(companyURL ?? "no name")\n"
        text += "Company logo: \(companyLogo ?? "no logo")\n"
        text += "URL: \(url)\n"
        print(text)
    }
}
