//
//  DetailedViewController.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

final class DetailedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == Section.episodes.rawValue ? 16 : 0
    }

    enum Section: Int, CaseIterable {
        case detailedCharacter
        case info
        case origin
        case episodes
    }

    // Update the numberOfSections method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    // Update the numberOfItemsInSection method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .detailedCharacter:
            return 1
        case .info:
            return 1
        case .origin:
            return 1
        case .episodes:
            return detailedViewModel.episode.count
        case .none:
            return 0
        }
    }

    // Update the cellForItemAt method to handle the DetailedCharacterCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch section {
        case .detailedCharacter:
            // Create and configure the DetailedCharacterCell
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailedCharacterCell.identifier, for: indexPath) as? DetailedCharacterCell else {
                fatalError("Unable to dequeue DetailedCharacterCell")
            }
            cell.setupCell(viewModel: detailedViewModel)
            return cell

        case .info:
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else {
                    fatalError("Unable to dequeue InfoCell")
                }
                cell.setupCell(viewModel: detailedViewModel)
                return cell
            }

        case .origin:
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OriginCell.identifier, for: indexPath) as? OriginCell else {
                    fatalError("Unable to dequeue OriginCell")
                }
                cell.setupCell(viewModel: detailedViewModel)
                return cell
            }

        case .episodes:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCell.identifier, for: indexPath) as? EpisodesCell else {
                fatalError("Unable to dequeue EpisodesCell")
            }

            let episodeIndex = indexPath.item
            let episodeURL = detailedViewModel.episode[episodeIndex]
            cell.setupCell(viewModel: detailedViewModel, episodeURL: episodeURL)

            return cell
        }

        return UICollectionViewCell()
    }


    private var collectionView: UICollectionView!
    let detailedViewModel: DetailedViewmodel

    init(_ detailedViewModel: DetailedViewmodel) {
        self.detailedViewModel = detailedViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.identifier)
        collectionView.register(OriginCell.self, forCellWithReuseIdentifier: OriginCell.identifier)
        collectionView.register(EpisodesCell.self, forCellWithReuseIdentifier: EpisodesCell.identifier)
        collectionView.register(DetailedCharacterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailedCharacterCell.identifier)
        collectionView.register(InfoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "InfoHeader")
        collectionView.register(OriginHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OriginHeader")
        collectionView.register(EpisodesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EpisodesHeader")
        setupConstraints()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(named: "Space")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 64
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
}

extension DetailedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        if indexPath.section == Section.detailedCharacter.rawValue {
            return CGSize(width: width, height: 210) // Adjust the height as needed to create more space
        } else if indexPath.section == Section.info.rawValue {
            return CGSize(width: width, height: 124)
        } else if indexPath.section == Section.origin.rawValue && indexPath.item == 0 {
            return CGSize(width: width, height: 80)
        } else {
            return CGSize(width: width, height: 86)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == Section.detailedCharacter.rawValue {
            return CGSize(width: collectionView.frame.width, height: -10) // Adjust the height to move the first element higher
        } else {
            return CGSize(width: collectionView.frame.width, height: 64) // For other sections
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == Section.detailedCharacter.rawValue {
            return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0) // Custom inset for detailedCharacter section
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Default inset for other sections
        }
    }

}

extension DetailedViewController {
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

class InfoHeader: UICollectionReusableView {
    static let identifier = "InfoHeader"
}

class EpisodesHeader: UICollectionReusableView {
    static let identifier = "EpisodesHeader"
}

class OriginHeader: UICollectionReusableView {
    static let identifier = "OriginHeader"
}
