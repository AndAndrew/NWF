//
//  DetailWeatherForecastPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 15.05.2022.
//

import Foundation

protocol DetailWeatherForecastViewProtocol {
    func setWeatherForecast(weatherForecast: WeatherForecast?, index: Int)
}

protocol DetailWeatherForecastViewPresenterProtocol {
    init(view: DetailWeatherForecastViewProtocol, router: RouterProtocol, weatherForecast: WeatherForecast?, index: Int?)
    func setWeatherForecast()
}

class DetailWeatherForecastPresenter: DetailWeatherForecastViewPresenterProtocol {
    var view: DetailWeatherForecastViewProtocol?
    var router: RouterProtocol?
    var weatherForecast: WeatherForecast?
    var index: Int?
    
    required init(view: DetailWeatherForecastViewProtocol, router: RouterProtocol, weatherForecast: WeatherForecast?, index: Int?) {
        self.view = view
        self.router = router
        self.weatherForecast = weatherForecast
        self.index = index
    }
    
    public func setWeatherForecast() {
        self.view?.setWeatherForecast(weatherForecast: weatherForecast, index: index!)
    }
}
