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
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFit
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
        
        let placeholderImage = UIImage(named: "placeholder")?.resized(to: CGSize(width: 140, height: 140))
        
        characterImage.image = placeholderImage
        characterImage.layer.cornerRadius = 16
        characterImage.clipsToBounds = true

        if let imageUrlString = viewModel.image, let imageUrl = URL(string: imageUrlString) {
            viewModel.loadImage(url: imageUrl) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    if let imageUrl = viewModel.image {
                        imageCache[imageUrl] = image
                    }
                    
                    let resizedImage = image.resized(to: CGSize(width: 140, height: 140))
                    self.characterImage.image = resizedImage
                    self.characterImage.layer.cornerRadius = 16
                    self.characterImage.clipsToBounds = true
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
            characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
        nameLabel.setContentCompressionResistancePriority(.required - 1, for: .vertical)
        characterImage.layer.cornerRadius = 16
    }
}

extension UIImage {
    func withRoundedCorners(radius: CGFloat) -> UIImage? {
        UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { context in
            let rect = CGRect(origin: .zero, size: size)
            context.cgContext.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
            context.cgContext.clip()
            draw(in: rect)
        }
    }
}
