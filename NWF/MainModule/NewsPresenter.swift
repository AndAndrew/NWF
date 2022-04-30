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
    init(view: NewsViewProtocol, networkService: NetworkServiceProtocol)
    func getNews()
    var news: News? { get set }
}

class NewsPresenter: NewsViewPresenterProtocol {
    var view: NewsViewProtocol?
    let networkService: NetworkServiceProtocol
    var news: News?
    
    required init(view: NewsViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getNews()
    }
    func getNews() {
        networkService.getNews { [weak self] result in
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
