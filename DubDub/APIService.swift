//
//  NetworkManager.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

public typealias JSON = [String: AnyObject]

enum Result {
    case success([AnyObject])
    case failure(APIError)
}

enum APIError: Error {
	case requestFailed(String)
	case invalidData(String)
	case invalidQuery(String)
	case invalidURL(String)
	case jsonError(String)
}

class APIService {
    
    private static let errorDomain = "com.dubdub.apiservice.error"
    
    private let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func getEventsFor(query: String?, onPage page: Int, completion: @escaping (Result) -> Void) {
        
        guard let queryString = query else {
            completion(.failure(.invalidQuery("Invalid Query")))
            return
        }
        
        APIManager.query = queryString
        APIManager.page = page
        let url = APIManager.eventsURL
        
        guard let uri = url else {
			completion(.failure(.invalidURL("Invalid URL")))
            return
        }
        
        let request = URLRequest(url: uri)
        
        cancelAllPreviousTasks()
        
        let task = session.dataTask(with: request) { (data, response, error) in
			
			guard let httpResponse = response as? HTTPURLResponse else {
				if let err = error {
					completion(.failure(.requestFailed(err.localizedDescription)))
				}
				return
			}
			
			if httpResponse.statusCode == 200 {
				if let data = data {
					do {
						if let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
							DispatchQueue.global(qos: .background).async {
								let dataParser = EventParser()
								dataParser.parse(jsonData)
							}
                            
                            completion(.success(Array()))    
						}
					} catch let err {
						completion(.failure(.jsonError(err.localizedDescription)))
					}
				} else {
					completion(.failure(.invalidData("Invalid data received")))
				}
			}
        }
        
        task.resume()
    }
    
    private func cancelAllPreviousTasks() {
        session.getAllTasks { (tasks) in
            _ = tasks.map{$0.cancel()}
        }
    }
}
