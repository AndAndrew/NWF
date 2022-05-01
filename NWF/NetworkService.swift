//
//  NetworkService.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 30.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData<T: Decodable>(fromURLString: String, completion: @escaping (Result<T, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func getData<T: Decodable>(fromURLString urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let JSON = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(JSON))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
