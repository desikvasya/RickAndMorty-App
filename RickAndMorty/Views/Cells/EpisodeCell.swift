//
//  EpisodesCell.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class EpisodesCell: UICollectionViewCell {
    
    static let identifier = "EpisodesCell"
    
    private var bottomSpacingConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let episodeName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
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
    
    private func updateUI(with episode: Episode) {
        episodeName.text = episode.name
        episodeNumber.text = convertToEpisodeFormat(episode.episode)
        episodeDate.text = episode.airDate
    }
    
    func setupCell(viewModel: DetailedViewmodel, episodeURL: String) {
        if let url = URL(string: episodeURL) {
            viewModel.fetchEpisodeData(fromURL: url) { result in
                switch result {
                case .success(let episode):
                    DispatchQueue.main.async {
                        self.updateUI(with: episode)
                    }
                case .failure(let error):
                    print("Error fetching episode data: \(error)")
                }
            }
        }
    }

    func convertToEpisodeFormat(_ input: String) -> String {
        let scanner = Scanner(string: input)
        var season: Int = 0
        var episode: Int = 0
        scanner.scanString("S", into: nil)
        scanner.scanInt(&season)
        scanner.scanString("E", into: nil)
        scanner.scanInt(&episode)
        let formattedString = "Episode: \(episode), Season: \(season)"
        return formattedString
    }
    
    private func setupViews() {
        layer.cornerRadius = 16
        addSubview(episodeName)
        addSubview(episodeNumber)
        addSubview(episodeDate)
        
        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            episodeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            episodeDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            episodeDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            episodeNumber.centerYAnchor.constraint(equalTo: episodeDate.centerYAnchor),
            episodeNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
        ])
    }
}
