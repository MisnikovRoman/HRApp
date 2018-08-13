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
}
