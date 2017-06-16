//
//  NetworkManager.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class APIService {
    
    private static let errorDomain = "com.dubdub.apiservice.error"
    
    private let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    final func getEventsFor(query: String?, onPage page: Int, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        guard let queryString = query else {
            let err = NSError(domain: APIService.errorDomain, code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid Query"])
            completion(.failure(err))
            return
        }
        
        APIManager.query = queryString
        APIManager.page = page
        let url = APIManager.eventsURL
        
        guard let uri = url else {
            let err = NSError(domain: APIService.errorDomain, code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(err))
            return
        }
        
        let request = URLRequest(url: uri)
        let task = session.dataTask(with: request) { (data, response, error) in
            print(data ?? "No data")
            print(response ?? "No response")
        }
        
        task.resume()
    }
}
