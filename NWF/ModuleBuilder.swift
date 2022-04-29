//
//  ModuleBuilder.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = Item(name: "Hello!")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, item: model)
        view.presenter = presenter
        return view
    }
    
    static func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.setNavigationBarHidden(true, animated: true)
        return navigationVC
    }
}
