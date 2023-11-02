//
//  OriginCell.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class OriginCell: UICollectionViewCell {
    
    static let identifier = "OriginCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let episodesHeader: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let planetName: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var planetImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Planet")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        backgroundColor = UIColor(named: "CellColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewModel: DetailedViewmodel) {
        planetLabel.text = viewModel.origin?.name == "unknown" ? "Unknown" : viewModel.origin?.name
        planetName.text = "Planet"
        headerLabel.text = "Origin"
        episodesHeader.text = "Episodes"
    }
    
    private func setupViews() {
        layer.cornerRadius = 16
        
        // Create the dark gray square with rounded corners
        let squareView = UIView()
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = UIColor(named: "PlanetBackground")
        squareView.layer.cornerRadius = 16
        addSubview(squareView)
        
        addSubview(headerLabel)
        addSubview(episodesHeader)
        addSubview(planetName)
        addSubview(planetLabel)
        addSubview(planetImage)
        
        NSLayoutConstraint.activate([
            // Constraints for the dark gray square
            squareView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            squareView.centerYAnchor.constraint(equalTo: centerYAnchor),
            squareView.widthAnchor.constraint(equalToConstant: 64),
            squareView.heightAnchor.constraint(equalToConstant: 64),
            
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: -40),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            episodesHeader.topAnchor.constraint(equalTo: bottomAnchor, constant: 24),
            episodesHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // Constraints for the planet image
            planetImage.centerXAnchor.constraint(equalTo: squareView.centerXAnchor),
            planetImage.centerYAnchor.constraint(equalTo: squareView.centerYAnchor),
            planetImage.widthAnchor.constraint(equalTo: squareView.widthAnchor, multiplier: 0.35),
            planetImage.heightAnchor.constraint(equalTo: squareView.heightAnchor, multiplier: 0.35),
            
            // Constraints for the planet name label
            planetLabel.centerYAnchor.constraint(equalTo: squareView.topAnchor, constant: 15),
            planetLabel.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: 15),
            
            // Constraints for the planet label
            planetName.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 10),
            planetName.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: 15),
            planetName.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
        ])
    }
}
