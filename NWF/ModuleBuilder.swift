//
//  ModuleBuilder.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import UIKit

protocol Builder {
    static func createNewsModule() -> UIViewController
    static func createWeatherForecastModule() -> UIViewController
    static func createDetailWeatherForecastModule(weatherForecast: WeatherForecast?, index: Int?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createNewsModule() -> UIViewController {
        let view = NewsViewController()
        let networkService = NetworkService()
        let presenter = NewsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createWeatherForecastModule() -> UIViewController {
        let view = WeatherForecastViewController()
        let networkService = NetworkService()
        let presenter = WeatherForecastPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailWeatherForecastModule(weatherForecast: WeatherForecast?, index: Int?) -> UIViewController {
        let view = DetailWeatherForecastViewController()
        let presenter = DetailWeatherForecastPresenter(view: view, weatherForecast: weatherForecast, index: index!)
        view.presenter = presenter
        return view
    }
    
    static func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
