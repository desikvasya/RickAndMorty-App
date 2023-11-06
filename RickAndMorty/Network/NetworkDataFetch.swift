//
//  NetworkDataFetch.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchCharacters(url: String, response: @escaping ([DetailsCharacter]?, NetworkError?) -> Void) {
        guard let charactersURL = URL(string: url) else {
            response(nil, .urlRequestError(NetworkError.urlSessionError))
            return
        }
        
        URLSession.shared.dataTask(with: charactersURL) { data, _, error in
            if let error = error {
                response(nil, .urlRequestError(error))
                return
            }
            
            guard let data = data else {
                response(nil, .urlSessionError)
                return
            }
            
            do {
                let welcome = try JSONDecoder().decode(BaseInfo.self, from: data)
                let characters = welcome.results
                response(characters, nil)
            } catch {
                response(nil, .urlRequestError(error))
            }
        }.resume()
    }
    
    
    func fetchEpisodeData(fromURL url: URL, completion: @escaping (Result<Episode, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.urlSessionError))
                return
            }
            
            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                completion(.success(episode))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
