//
//  NewsPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import Foundation

protocol NewsViewProtocol {
    func success()
    func failure(error: Error)
}

protocol NewsViewPresenterProtocol {
    init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getNews()
    var news: News? { get set }
}

class NewsPresenter: NewsViewPresenterProtocol {
    var view: NewsViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol
    var news: News?
    
    required init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getNews()
    }
    func getNews() {
        networkService.getData(fromURLString: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=f72d06e2351a4a72bf54a30cce6aba82") { [weak self] (result: Result<News?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.news = news
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
