//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    
    func appendingQueryItem(name: String, value: String) -> Self {
        var updatedEndpoint = self
        let queryItem = URLQueryItem(name: name, value: value)
        updatedEndpoint.queryItems.append(queryItem)
        return updatedEndpoint
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Wrong URL")
        }
        return url
    }
}

extension Endpoint {
    static var characters: Self {
        Endpoint(path: "character")
    }
}
