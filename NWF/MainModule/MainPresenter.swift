//
//  MainPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import Foundation

protocol MainViewProtocol {
    func setString(string: String)
}

protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, item: Item)
    func showString()
}

class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let item: Item
    
    required init(view: MainViewProtocol, item: Item) {
        self.view = view
        self.item = item
    }
    
    func showString() {
        let string = self.item.name
        self.view.setString(string: string)
    }
}
