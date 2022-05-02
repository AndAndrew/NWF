//
//  WeatherForecastPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 02.05.2022.
//

import Foundation

protocol WeatherForecastViewProtocol {
    func success()
    func failure(error: Error)
}

protocol WeatherForecastViewPresenterProtocol {
    init(view: WeatherForecastViewProtocol, networkService: NetworkServiceProtocol)
    func getWeatherForecast()
    var weatherForecast: WeatherForecast? { get set }
}

class NWeatherForecastPresenter: WeatherForecastViewPresenterProtocol {
    var view: WeatherForecastViewProtocol?
    let networkService: NetworkServiceProtocol
    var weatherForecast: WeatherForecast?
    
    required init(view: WeatherForecastViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getWeatherForecast()
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
}
