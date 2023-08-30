//
//  BreedResponse.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

struct BreedResponse: Decodable {
    var id: String
    var name: String
    var reference_image_id: String?
    var wikipedia_url: String?
}

struct BreedImgResponse: Decodable {
    var url: String?
}
