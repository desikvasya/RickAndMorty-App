//
//  MainCellViewModel.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

private let cacheQueue = DispatchQueue(label: "com.example.imageCacheQueue")

class MainCellViewModel {
    var name: String?
    var status: Status
    var image: String?
    weak var viewController: CharactersViewController?
    
    init(_ character: DetailsCharacter) {
        self.name = character.name
        self.status = character.status
        self.image = character.image
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
    
    func loadImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageUrlString = url.absoluteString
        
        if let cachedImage = imageCache[imageUrlString] {
            completion(.success(cachedImage))
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    cacheQueue.sync {
                        imageCache[imageUrlString] = image
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        // Error handling: Show an alert to the user
                        if let viewController = self.viewController {
                            let alertController = UIAlertController(title: "Error", message: "Failed to load image", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            viewController.present(alertController, animated: true, completion: nil)
                        }
                        
                        completion(.failure(NetworkError.urlSessionError))
                    }
                }
            }
        }
    }
}
