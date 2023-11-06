//
//  MainCell.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

var imageCache = [String: UIImage]()

class MainCell: UICollectionViewCell {
    
    static let identifier = "MainCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill 
        image.clipsToBounds = true
        return image
    }()
    
    private var imageUrl: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = UIColor(named: "CellColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewModel: MainCellViewModel) {
        nameLabel.text = viewModel.name
        
        let placeholderImage = UIImage(named: "placeholder")
        
        characterImage.image = placeholderImage
        
        if let imageUrlString = viewModel.image, let imageUrl = URL(string: imageUrlString) {
            viewModel.loadImage(url: imageUrl) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    if let imageUrl = viewModel.image {
                        imageCache[imageUrl] = image
                    }
                    
                    self.characterImage.image = image
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        } else {
            print("Invalid image URL")
        }
    }
    
    private func setupViews() {
        layer.cornerRadius = 16
        
        addSubview(nameLabel)
        addSubview(characterImage)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            characterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            characterImage.heightAnchor.constraint(equalToConstant: 140),
        ])
        
        let constraint1 = nameLabel.topAnchor.constraint(lessThanOrEqualTo: characterImage.bottomAnchor, constant: 16)
        constraint1.priority = UILayoutPriority(1000)
        constraint1.isActive = true
        let constraint2 = nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        constraint2.priority = UILayoutPriority(999)
        constraint2.isActive = true
    }
}
