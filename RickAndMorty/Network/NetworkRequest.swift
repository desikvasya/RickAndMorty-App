//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {}
    
    func getData(forPage page: Int, completionHandle: @escaping (Result<Data, NetworkError>) -> Void) {
        let endpoint = Endpoint.characters.appendingQueryItem(name: "page", value: "\(page)")
        print("\(endpoint)")
        URLSession.shared.request(endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completionHandle(.success(data))
                case .failure(let error):
                    completionHandle(.failure(error))
                }
            }
        }
    }
}
