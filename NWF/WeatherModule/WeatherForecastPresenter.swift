//
//  WeatherForecastPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 02.05.2022.
//

import Foundation
import UIKit

protocol WeatherForecastViewProtocol {
    func success()
    func failure(error: Error)
    func setWeatherForecastData(weatherForecast: WeatherForecast?)
}

protocol WeatherForecastViewPresenterProtocol {
    init(view: WeatherForecastViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getWeatherForecast()
    func setWeatherForecastData()
    var weatherForecast: WeatherForecast? { get set }
    func tapOnCollectionCell(navVC: UINavigationController, weatherForecast: WeatherForecast?, index: Int?)
}

class WeatherForecastPresenter: WeatherForecastViewPresenterProtocol {
    
    var view: WeatherForecastViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    var weatherForecast: WeatherForecast?
    
    required init(view: WeatherForecastViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getWeatherForecast()
    }
    func tapOnCollectionCell(navVC: UINavigationController, weatherForecast: WeatherForecast?, index: Int?) {
        router?.showDetailWeatherForecast(navigationController: navVC, weatherForecast: weatherForecast, index: index)
    }
    func getWeatherForecast() {
        networkService.getData(fromURLString: "https://api.openweathermap.org/data/2.5/forecast?id=499099&appid=10e947c470cd64d82b9e40cb86162e8f") { [weak self] (result: Result<WeatherForecast?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherForecast):
                    self.weatherForecast = weatherForecast
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    public func setWeatherForecastData() {
        self.view?.setWeatherForecastData(weatherForecast: weatherForecast)
    }
}
