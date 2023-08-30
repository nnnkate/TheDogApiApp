//
//  NetworkManager.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol NetworkManagerProtocol {
    func loadData(page: Int,
                  completion: @escaping ([BreedResponse]?, Error?) -> ())
    func loadImage(id: String,
                  completion: @escaping (BreedImgResponse?, Error?) -> ())
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> ())
}

final class NetworkManager {
    
}

// MARK: - Fetch
extension NetworkManager {
    
    private func fetchData(urlString: String,
                           completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
    
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    
    func loadData(page: Int,
                  completion: @escaping ([BreedResponse]?, Error?) -> ()) {
        let urlString = "https://api.thecatapi.com/v1/breeds?limit=10&page=\(page)"
        fetchData(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data else { return }
            let decoder = JSONDecoder()
            do {
                completion(try decoder.decode(Array<BreedResponse>.self, from: data), nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
        
    func loadImage(id: String,
                  completion: @escaping (BreedImgResponse?, Error?) -> ()) {
        let urlString = "https://api.thecatapi.com/v1/images/\(id)"
        fetchData(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data else { return }
            let decoder = JSONDecoder()
            do {
                completion(try decoder.decode(BreedImgResponse.self, from: data), nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
        
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data))
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let http = URL(string: url.absoluteString), var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) {
            comps.scheme = "https"
            if let url = comps.url {
                URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
            }
        }
    }


}

