//
//  DetailedCharacterCell.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class DetailedCharacterCell: UICollectionViewCell {
    static let identifier = "DetailedCharacterCell"

    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(name)
        addSubview(status)
        addSubview(characterImage)

        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            characterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 20),
            status.centerXAnchor.constraint(equalTo: centerXAnchor),
            status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
        ])
    }

    func setupCell(viewModel: DetailedViewmodel) {
        name.text = viewModel.name
        status.text = viewModel.statusString
        if viewModel.status == .alive {
            status.textColor = .systemGreen
        } else if viewModel.status == .dead {
            status.textColor = .red
        } else {
            status.textColor = .yellow
        }

        setupImage(viewModel: viewModel)
    }

    func setupImage(viewModel: DetailedViewmodel) {
        let placeholderImage = UIImage(named: "placeholder")?.resized(to: CGSize(width: 148, height: 148))

        characterImage.image = placeholderImage

        if let imageUrl = viewModel.image, let cachedImage = imageCache[imageUrl] {
            let resizedImage = cachedImage.resized(to: CGSize(width: 148, height: 148))
            characterImage.image = resizedImage
        } else {
            viewModel.fetchImage { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let image):
                    if let imageUrl = viewModel.image {
                        imageCache[imageUrl] = image
                    }

                    let resizedImage = image.resized(to: CGSize(width: 148, height: 148))
                    self.characterImage.image = resizedImage
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
