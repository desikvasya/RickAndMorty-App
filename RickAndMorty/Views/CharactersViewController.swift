//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var viewModel = MainViewModel()
    
    let activityIndicator = UIActivityIndicatorView()
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    var cellDataSource = [MainCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindViewModel()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        setupCollectionView()
        viewModel.getCharacters()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "Space")
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Space")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        setupCollectionView()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.color = .white
    }
    
    func presentDetailedViewController(character: DetailsCharacter) {
        let detailedViewModel = DetailedViewmodel(characters: character)
        let detailedVC = DetailedViewController(detailedViewModel)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationItem.backBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
            
        }
        viewModel.cellDataSource.bind { [weak self] characters in
            guard let self = self, let characters = characters else { return }
            self.cellDataSource = characters!
            self.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension CharactersViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
