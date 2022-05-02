//
//  WeatherForecastViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 02.05.2022.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    var presenter: WeatherForecastViewPresenterProtocol!
    
    var temperatureLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.tintColor = .systemRed
        setupViews()
        setupConstrainst()
    }
    
    private func setupViews() {
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont(name: "Rockwell", size: 80)
        temperatureLabel.textAlignment = .center
        temperatureLabel.contentMode = .center
        view.addSubview(temperatureLabel)
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension WeatherForecastViewController: WeatherForecastViewProtocol {
    func success(weatherForecast: WeatherForecast) {
        temperatureLabel.text = "\(Int(round(weatherForecast.list[0].main.temp - 273.15)))ºC"
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
