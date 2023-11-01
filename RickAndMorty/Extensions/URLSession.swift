//
//  URLSession.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

extension URLSession {
    
    typealias Handler = (Result<Data, NetworkError>) -> Void
    
    @discardableResult
    func request (
        _ endpoint: Endpoint,
        handler: @escaping Handler) -> URLSessionDataTask {
            
            let task = dataTask(with: endpoint.url) { data, response, error in
                if let error = error {
                    handler(.failure(.urlRequestError(error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    handler(.failure(.urlSessionError))
                    return
                }
                
                guard (200 ..< 300) ~= response.statusCode else {
                    handler(.failure(.httpStatusCode(response.statusCode)))
                    return
                }
                
                if let data = data {
                    handler(.success(data))
                } else {
                    handler(.failure(.urlSessionError))
                }
            }
            
            task.resume()
            return task
        }
}
