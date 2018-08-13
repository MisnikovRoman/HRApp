//
//  NetworkError.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case noResponseFromServer
    case responseError
}
