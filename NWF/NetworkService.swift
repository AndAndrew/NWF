//
//  NetworkService.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 30.04.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<News?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<News?, Error>) -> ()) {
        
        let urlString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=f72d06e2351a4a72bf54a30cce6aba82"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let newsJSON = try JSONDecoder().decode(News.self, from: data!)
                completion(.success(newsJSON))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
