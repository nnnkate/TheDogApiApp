//
//  BreedModel.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol BreedModelSubscriber {
    func notify(imageId: String?)
}

final class BreedModel: BaseCollectionViewCellItem {
    
    private(set) var title: String
    private(set) var image: UIImage?
    private(set) var link: String?
    private(set) var imageId: String?
    
    var subscriber: BreedModelSubscriber?
    
    init(title: String, link: String?, imageId: String?) {
        self.title = title
        self.link = link
        self.imageId = imageId
        super.init()
    }
    
}

extension BreedModel {
    
    func set(image: UIImage?) {
        self.image = image
        subscriber?.notify(imageId: imageId)
    }
    
}
