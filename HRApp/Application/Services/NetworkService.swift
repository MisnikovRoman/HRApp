//
//  NetworkService.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

enum NetworkResult {
    case success(data: Any)
    case failure(error: Error)
    
    var data: Any? {
        switch self {
        case .success(let data):
            return data
        case .failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (NetworkResult)->()) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            // error handling - send by chain error
            if let error = error { completion(.failure(error: error)) }
            // no data error
            if data == nil { completion(.failure(error: NetworkError.noInternetConnection)) }
            // response error
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode != 200 { completion(.failure(error: NetworkError.responseError))}
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let allVacancies = try decoder.decode([Vacancy].self, from: data)
                completion(NetworkResult.success(data: allVacancies))
            } catch (let error) {
                completion(NetworkResult.failure(error: error))
            }
            
        }
        task.resume()
    }
    
    
    
}
