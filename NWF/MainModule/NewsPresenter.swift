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
    init(view: NewsViewProtocol, item: Item)
    func showString()
}

class NewsPresenter: NewsViewPresenterProtocol {
    let view: NewsViewProtocol
    let item: Item
    
    required init(view: NewsViewProtocol, item: Item) {
        self.view = view
        self.item = item
    }
    
    func showString() {
        let string = self.item.name
        self.view.setString(string: string)
    }
}
