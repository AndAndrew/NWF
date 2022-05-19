//
//  DetailWeatherForecastViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 15.05.2022.
//

import UIKit

class DetailWeatherForecastViewController: UIViewController {
    
    var presenter: DetailWeatherForecastViewPresenterProtocol!
    
    var cityLabel: UILabel!
    var temperatureLabel: UILabel!
    var weatherImageView: UIImageView!
    var labelsStack: UIStackView!
    var feelsLikeStack: TwoLabelStack!
    var pressureStack: TwoLabelStack!
    var humidityStack: TwoLabelStack!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        setupViews()
        presenter.setWeatherForecast()
        setupConstrainst()
    }
    
    private func setupViews() {
        
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "City"
        cityLabel.highlightedTextColor = .systemGray2
        cityLabel.isHighlighted = true
        cityLabel.font = UIFont(name: "Rockwell", size: 65)
        cityLabel.minimumScaleFactor = 0.4
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.textAlignment = .center
        cityLabel.contentMode = .center
        view.addSubview(cityLabel)
        
        temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.highlightedTextColor = .systemGray2
        temperatureLabel.isHighlighted = true
        temperatureLabel.font = UIFont(name: "Rockwell", size: 80)
        temperatureLabel.minimumScaleFactor = 0.4
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .center
        temperatureLabel.contentMode = .center
        view.addSubview(temperatureLabel)
        
        weatherImageView = UIImageView()
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.highlightedImage = UIImage(systemName: "globe.europe.africa.fill")
        weatherImageView.isHighlighted = true
        weatherImageView.tintColor = .systemGray2
        view.addSubview(weatherImageView)
        
        feelsLikeStack = TwoLabelStack()
        feelsLikeStack.titleLabel.text = "Feels like"
        
        pressureStack = TwoLabelStack()
        pressureStack.titleLabel.text = "Pressure"
        
        humidityStack = TwoLabelStack()
        humidityStack.titleLabel.text = "Humidity"
        
        labelsStack = UIStackView()
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.distribution = .fillEqually
        labelsStack.axis = .horizontal
        labelsStack.spacing = 5
        labelsStack.addArrangedSubview(feelsLikeStack)
        labelsStack.addArrangedSubview(humidityStack)
        labelsStack.addArrangedSubview(pressureStack)
        view.addSubview(labelsStack)
    }
    
    private func setupConstrainst() {
        let thirdOfViewHeight = (view.safeAreaLayoutGuide.layoutFrame.size.height - (tabBarController?.tabBar.frame.size.height ?? 0) - (navigationController?.navigationBar.frame.size.height ?? 0)) / 3
        NSLayoutConstraint.activate([
            
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            
            weatherImageView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelsStack.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            labelsStack.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            labelsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DetailWeatherForecastViewController: DetailWeatherForecastViewProtocol {
    func setWeatherForecast(weatherForecast: WeatherForecast?, index: Int) {
        guard let weatherForecast = weatherForecast else { return }
        let main = weatherForecast.list[index].main
        
        cityLabel.text = weatherForecast.city.name
        cityLabel.isHighlighted = false
        
        temperatureLabel.text = "\(Int(round((main.temp) - 273.15)))ºC"
        temperatureLabel.isHighlighted = false
        
        if let url = URL(string: "https://openweathermap.org/img/wn/\(weatherForecast.list[index].weather[0].icon)@4x.png") {
            weatherImageView.isHighlighted = false
            guard let data = try? Data(contentsOf: url) else { return }
            weatherImageView.image = UIImage(data: data)
        }
        
        feelsLikeStack.contentLabel.text = "\(Int(round((main.feels_like) - 273.15)))ºC"
        humidityStack.contentLabel.text = "\(main.humidity)%"
        pressureStack.contentLabel.text = "\(Int(round(Float(main.pressure) * 0.750062)))mm"
    }
}


