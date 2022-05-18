//
//  Router.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 18.05.2022.
//

import UIKit

protocol RouterMain {
    var tabBarController: UITabBarController? { get set }
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailWeatherForecast(navigationController: UINavigationController?, weatherForecast: WeatherForecast?, index: Int?)
    func poopToRoot()
}

class Router: RouterProtocol {
    
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(tabBarController: UITabBarController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = tabBarController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let tabBarController = tabBarController {
            guard let newsViewController = assemblyBuilder?.createNewsModule(router: self),
                  let weatherForecastViewController = assemblyBuilder?.createWeatherForecastModule(router: self) else { return }
            let navigationNewsVC = generateNavigationController(rootViewController: newsViewController, title: "News", image: UIImage(systemName: "newspaper.fill") ?? UIImage())
            let navigationWeatherForecastVC = generateNavigationController(rootViewController: weatherForecastViewController, title: "Weather", image: UIImage(systemName: "sun.min.fill") ?? UIImage())
            tabBarController.viewControllers = [navigationNewsVC, navigationWeatherForecastVC]
        }
    }
    
    func showDetailWeatherForecast(navigationController: UINavigationController?, weatherForecast: WeatherForecast?, index: Int?) {
        if let navigationController = navigationController {
            guard let detailWeatherForecastViewController = assemblyBuilder?.createDetailWeatherForecastModule(weatherForecast: weatherForecast, index: index, router: self) else { return }
            navigationController.pushViewController(detailWeatherForecastViewController, animated: true)
        }
    }
    
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
    func poopToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
