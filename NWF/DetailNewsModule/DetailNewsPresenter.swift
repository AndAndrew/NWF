//
//  DetailNewsPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 26.05.2022.
//

import Foundation

protocol DetailNewsViewProtocol {
    func setNews(news: News?, index: Int)
}

protocol DetailNewsViewPresenterProtocol {
    init(view: DetailNewsViewProtocol, router: RouterProtocol, news: News?, index: Int?)
    func setNews()
}

class DetailNewsPresenter: DetailNewsViewPresenterProtocol {
    var view: DetailNewsViewProtocol?
    var router: RouterProtocol?
    var news: News?
    var index: Int?
    
    required init(view: DetailNewsViewProtocol, router: RouterProtocol, news: News?, index: Int?) {
        self.view = view
        self.router = router
        self.news = news
        self.index = index
    }
    
    public func setNews() {
        self.view?.setNews(news: news, index: index!)
    }
}
