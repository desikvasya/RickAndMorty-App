//
//  DetailedViewModel.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class DetailedViewmodel {
    
    let name: String
    let status: Status
    let species: String
    let type: String
    var image: String?
    
    var episodeData: [Episode] = []
    
    let gender: Gender
    let origin, location: Location?
    let episode: [String]
    let created: String
    
    init(characters: DetailsCharacter) {
        self.name = characters.name
        self.status = characters.status
        self.species = characters.species
        self.type = characters.type
        self.gender = characters.gender
        self.origin = characters.origin
        self.location = characters.location
        self.image = characters.image
        self.episode = characters.episode
        self.created = characters.created
        self.image = characters.image
        
    }
    
    var statusString: String {
        switch status {
        case .alive:
            return "Alive"
        case .dead:
            return "Dead"
        case .unknown:
            return "Unknown"
        }
    }
    
    var genderString: String {
        switch gender {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .unknown:
            return "Unknown"
        case .genderless:
            return "Genderless"
        }
    }
    
    var imageUrl: String?
    
    public func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.urlSessionError))
                return
            }
            
            completion(.success(image))
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
