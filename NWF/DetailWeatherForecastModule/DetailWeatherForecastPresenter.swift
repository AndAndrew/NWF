//
//  DetailWeatherForecastPresenter.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 15.05.2022.
//

import Foundation

protocol DetailWeatherForecastViewProtocol {
    func setWeatherForecast(weatherForecast: WeatherForecast?)
}

protocol DetailWeatherForecastViewPresenterProtocol {
    init(view: DetailWeatherForecastViewProtocol, weatherForecast: WeatherForecast?)
    func setWeatherForecast()
}

class DetailWeatherForecastPresenter: DetailWeatherForecastViewPresenterProtocol {
    var view: DetailWeatherForecastViewProtocol?
    var weatherForecast: WeatherForecast?
    
    required init(view: DetailWeatherForecastViewProtocol, weatherForecast: WeatherForecast?) {
        self.view = view
        self.weatherForecast = weatherForecast
    }
    
    public func setWeatherForecast() {
        self.view?.setWeatherForecast(weatherForecast: weatherForecast)
    }
}
