//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class InfoCell: UICollectionViewCell {
    
    static let identifier = "InfoCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let speciesText: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeText: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderText: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        headerLabel.text = "Info"
        genderLabel.text = viewModel.genderString
        speciesLabel.text = viewModel.species
        typeLabel.text = viewModel.type
        
        genderText.text = "Gender:"
        speciesText.text = "Species:"
        typeText.text = "Type:"
        
        if viewModel.type.isEmpty {
            typeLabel.text = "None"
        }
    }
    
    private func setupViews() {
        layer.cornerRadius = 16
        addSubview(genderLabel)
        addSubview(speciesLabel)
        addSubview(typeLabel)
        addSubview(headerLabel)
        
        addSubview(genderText)
        addSubview(speciesText)
        addSubview(typeText)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: -40),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            speciesLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 20),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            speciesText.centerYAnchor.constraint(equalTo: speciesLabel.centerYAnchor),
            speciesText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            typeText.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            typeText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20),
            
            genderText.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor),
            genderText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
    }
}
