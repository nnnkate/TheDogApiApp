//
//  NetworkManager.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

protocol NetworkManagerProtocol {
    func loadData(page: Int,
                  completion: @escaping ([BreedResponse]?, Error?) -> ())
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
    
}

