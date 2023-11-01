//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

final class MainViewModel {
    var isLoading: Observable<Bool> = Observable(value: false)
    var dataSource: [DetailsCharacter]?
    var cellDataSource: Observable<[MainCellViewModel]?> = Observable(value: nil)
    
    var isLoadingMore = false
    var currentPage = 1
    private var isRequestInProgress = false
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getCharacters() {
        guard !isRequestInProgress else {
            return
        }
        
        isRequestInProgress = true
        isLoading.value = true
        
        let urlForPage = "https://rickandmortyapi.com/api/character/?page=\(currentPage)"
        
        NetworkDataFetch.shared.fetchCharacters(url: urlForPage) { [weak self] characters, error in
            guard let self = self else { return }
            
            defer {
                self.isRequestInProgress = false
            }
            
            self.isLoading.value = false
            
            if let error = error {
                print("Error fetching characters: \(error)")
                return
            }
            
            guard let characters = characters else {
                print("Characters data is nil")
                return
            }
            
            if self.currentPage == 1 {
                self.dataSource = characters
            } else {
                self.dataSource?.append(contentsOf: characters)
            }
            
            self.currentPage += 1
            self.mapCellData()
        }
    }
    
    func mapCellData() {
        cellDataSource.value = dataSource?.compactMap { MainCellViewModel($0) }
    }
}
