//
//  ModuleBuilder.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createNewsModule(router: RouterProtocol) -> UIViewController
    func createWeatherForecastModule(router: RouterProtocol) -> UIViewController
    func createDetailWeatherForecastModule(weatherForecast: WeatherForecast?, index: Int?, router: RouterProtocol) -> UIViewController
    func createDetailNewsModule(news: News?, index: Int?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createNewsModule(router: RouterProtocol) -> UIViewController {
        let view = NewsViewController()
        let networkService = NetworkService()
        let presenter = NewsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createWeatherForecastModule(router: RouterProtocol) -> UIViewController {
        let view = WeatherForecastViewController()
        let networkService = NetworkService()
        let presenter = WeatherForecastPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailWeatherForecastModule(weatherForecast: WeatherForecast?, index: Int?, router: RouterProtocol) -> UIViewController {
            let view = DetailWeatherForecastViewController()
        let presenter = DetailWeatherForecastPresenter(view: view, router: router, weatherForecast: weatherForecast, index: index!)
            view.presenter = presenter
            return view
    }
    
    func createDetailNewsModule(news: News?, index: Int?, router: RouterProtocol) -> UIViewController {
        let view = DetailNewsViewController()
        let presenter = DetailNewsPresenter(view: view, router: router, news: news, index: index!)
        view.presenter = presenter
        return view
    }
}
