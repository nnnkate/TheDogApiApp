//
//  HomeViewModel.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

protocol HomeViewModelProtocol {
    func loadNextPage(completion: @escaping ([BreedModel], Bool) -> ())
    func loadPage(completion: @escaping ([BreedModel], Bool) -> ())
}

final class HomeViewModel {
    
    // - Data
    private(set) var items: [BreedModel] = []
    private(set) var currentPage = 0
    private(set) var isResultLoaded = false
    
    // - Manager
    private var manager: NetworkManagerProtocol = NetworkManager()
    
}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
   
    func loadPage(completion: @escaping ([BreedModel], Bool) -> ()) {
        loadBreeds(completion)
    }
    
    
    func loadNextPage(completion: @escaping ([BreedModel], Bool) -> ()) {
        currentPage += 1
        loadBreeds(completion)
    }
    
}

// MARK: - Load
private extension HomeViewModel {
    
    func loadBreeds(_ completion: @escaping ([BreedModel], Bool) -> ()) {
        if isResultLoaded {
            return
        }
        manager.loadData(page: currentPage) { [weak self] data, error in
            guard let self, let data else { return }
            if let error = error {
                debugPrint(error)
            }
            let newItems = data.map { BreedModel(title: $0.id) }
            self.isResultLoaded =  newItems.count < 10
            self.items.append(contentsOf: newItems)
            completion(items, isResultLoaded)
        }
    }
    
}
