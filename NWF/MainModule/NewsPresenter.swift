//
//  NewsPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import Foundation

protocol NewsViewProtocol {
    func setString(string: String)
}

protocol NewsViewPresenterProtocol {
    init(view: NewsViewProtocol, news: News)
    func showString()
}

class NewsPresenter: NewsViewPresenterProtocol {
    let view: NewsViewProtocol
    let news: News
    
    required init(view: NewsViewProtocol, news: News) {
        self.view = view
        self.news = news
    }
    
    func showString() {
    }
}
