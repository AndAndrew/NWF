//
//  WeatherForecastViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 02.05.2022.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    var presenter: WeatherForecastViewPresenterProtocol!
    var cellId = "cell"
    
    var anotherDayWeatherForecast: [(String, Int)]!
    var cityLabel: UILabel!
    var temperatureLabel: UILabel!
    var weatherImageView: UIImageView!
    var anotherDayForecastCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.tintColor = .systemRed
        setupViews()
        anotherDayForecastCollection.dataSource = self
        anotherDayForecastCollection.delegate = self
        anotherDayForecastCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        presenter.setWeatherForecastData()
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        anotherDayForecastCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        anotherDayForecastCollection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anotherDayForecastCollection)
    }
    
    private func setupConstrainst() {
        let thirdOfViewHeight = (view.safeAreaLayoutGuide.layoutFrame.size.height - (tabBarController?.tabBar.frame.size.height ?? 0)) / 3
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
            weatherImageView.heightAnchor.constraint(equalToConstant: thirdOfViewHeight),
            
            anotherDayForecastCollection.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            anotherDayForecastCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            anotherDayForecastCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            anotherDayForecastCollection.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2)
        ])
    }
}

extension WeatherForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        anotherDayWeatherForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        print("\(anotherDayWeatherForecast[indexPath.item].0) - \(anotherDayWeatherForecast[indexPath.item].1)")
        return cell
    }
}

extension WeatherForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height - 10, height: collectionView.frame.size.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension WeatherForecastViewController: WeatherForecastViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func setWeatherForecastData(weatherForecast: WeatherForecast?) {
        guard let weatherForecast = weatherForecast else { return }
        let main = weatherForecast.list[0].main
        
        cityLabel.text = weatherForecast.city.name
        cityLabel.isHighlighted = false
        
        temperatureLabel.text = "\(Int(round((main.temp) - 273.15)))ºC"
        temperatureLabel.isHighlighted = false
        
        if let url = URL(string: "https://openweathermap.org/img/wn/\(weatherForecast.list[0].weather[0].icon)@4x.png") {
            weatherImageView.isHighlighted = false
            guard let data = try? Data(contentsOf: url) else { return }
            weatherImageView.image = UIImage(data: data)
        }
        
        anotherDayWeatherForecast = getAnotherDayWeatherForecast(weatherForecast: weatherForecast)
        
    }
    
    func getAnotherDayWeatherForecast(weatherForecast: WeatherForecast) -> [(String, Int)] {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let anotherDayDateFormatter = DateFormatter()
        anotherDayDateFormatter.dateFormat = "dd.MM"
        let today = dateFormatter.date(from: weatherForecast.list[0].dt_txt)!
        let calendar = Calendar(identifier: .gregorian)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: today)!)
        let tomorrowIndex = weatherForecast.list.firstIndex(where: {$0.dt_txt == (dateFormatter.string(from: tomorrow))})!
        return [(anotherDayDateFormatter.string(from: dateFormatter.date(from: weatherForecast.list[tomorrowIndex].dt_txt)!), Int(round(weatherForecast.list[tomorrowIndex].main.temp - 273.15))),
                (anotherDayDateFormatter.string(from: dateFormatter.date(from: weatherForecast.list[tomorrowIndex + 8].dt_txt)!), Int(round(weatherForecast.list[tomorrowIndex + 8].main.temp - 273.15))),
                (anotherDayDateFormatter.string(from: dateFormatter.date(from: weatherForecast.list[tomorrowIndex + 16].dt_txt)!), Int(round(weatherForecast.list[tomorrowIndex + 16].main.temp - 273.15))),
                (anotherDayDateFormatter.string(from: dateFormatter.date(from: weatherForecast.list[tomorrowIndex + 24].dt_txt)!), Int(round(weatherForecast.list[tomorrowIndex + 24].main.temp - 273.15)))]
    }
}
