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
            
            let newItems = data.map { BreedModel(title: $0.name,
                                                 link: $0.wikipedia_url,
                                                 imageId: $0.reference_image_id) }
            self.isResultLoaded =  newItems.count < 10
            self.items.append(contentsOf: newItems)
            completion(items, isResultLoaded)
            loadImages()
        }
    }
    
    func loadImages() {
        items.filter({ $0.image == nil }).forEach { item in
            if let imageId = item.imageId {
                manager.loadImage(id: imageId) { [weak self] data, error in
                    if let error = error {
                        debugPrint(error)
                    }
                    
                    if let urlString = data?.url, let url = URL(string: urlString) {
                        self?.manager.downloadImage(from: url) { image in
                            item.set(image: image)
                        }
                    }
                }
            }
        }
    }
    
}


        

