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
    var anotherDayWeatherForecastIndexes: [Int: Int]!
    var cityLabel: UILabel!
    var temperatureLabel: UILabel!
    var weatherImageView: UIImageView!
    var weatherDescriptionLabel: UILabel!
    var anotherDayForecastCollection: UICollectionView!
    var labelsStack: UIStackView!
    var feelsLikeStack: TwoLabelStack!
    var pressureStack: TwoLabelStack!
    var humidityStack: TwoLabelStack!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        anotherDayWeatherForecast = []
        view.backgroundColor = .systemGray4
        tabBarController?.tabBar.tintColor = .systemRed
        setupViews()
        anotherDayForecastCollection.dataSource = self
        anotherDayForecastCollection.delegate = self
        anotherDayForecastCollection.register(WeatherForecastCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
        
        weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.highlightedTextColor = .systemGray2
        weatherDescriptionLabel.isHighlighted = true
        weatherDescriptionLabel.font = UIFont(name: "Rockwell", size: 25)
        weatherDescriptionLabel.minimumScaleFactor = 0.3
        weatherDescriptionLabel.adjustsFontSizeToFitWidth = true
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.contentMode = .center
        view.addSubview(weatherDescriptionLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        anotherDayForecastCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        anotherDayForecastCollection.translatesAutoresizingMaskIntoConstraints = false
        anotherDayForecastCollection.backgroundColor = .clear
        view.addSubview(anotherDayForecastCollection)
        
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
            weatherImageView.heightAnchor.constraint(equalToConstant: (thirdOfViewHeight * 3) / 4),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 4),
            
            anotherDayForecastCollection.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor),
            anotherDayForecastCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            anotherDayForecastCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            anotherDayForecastCollection.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            
            labelsStack.topAnchor.constraint(equalTo: anotherDayForecastCollection.bottomAnchor),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelsStack.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            labelsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WeatherForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        anotherDayWeatherForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherForecastCollectionViewCell
        cell.dateLabel.text = anotherDayWeatherForecast[indexPath.item].0
        cell.temperatureLabel.text = "\(anotherDayWeatherForecast[indexPath.item].1)ºC"
        return cell
    }
}

extension WeatherForecastViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherForecast = presenter.weatherForecast
        let index = anotherDayWeatherForecastIndexes[indexPath.item]
        presenter.tapOnCollectionCell(navVC: self.navigationController!, weatherForecast: weatherForecast, index: index)
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
        
        weatherDescriptionLabel.text = weatherForecast.list[0].weather[0].description
        weatherDescriptionLabel.isHighlighted = false
        
        getAnotherDayWeatherForecast(weatherForecast: weatherForecast)
        
        feelsLikeStack.contentLabel.text = "\(Int(round((main.feels_like) - 273.15)))ºC"
        humidityStack.contentLabel.text = "\(main.humidity)%"
        pressureStack.contentLabel.text = "\(Int(round(Float(main.pressure) * 0.750062)))mm"
    }
    
    func getAnotherDayWeatherForecast(weatherForecast: WeatherForecast) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let anotherDayDateFormatter = DateFormatter()
        anotherDayDateFormatter.dateFormat = "dd.MM HH:mm"
        let today = dateFormatter.date(from: weatherForecast.list[0].dt_txt)!
        let calendar = Calendar(identifier: .gregorian)
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: today)!)
        let tomorrowIndex = weatherForecast.list.firstIndex(where: {$0.dt_txt == (dateFormatter.string(from: tomorrow))})!
        anotherDayWeatherForecastIndexes = [0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6, 6: tomorrowIndex + 12, 7: tomorrowIndex + 20, 8: tomorrowIndex + 28]
        anotherDayWeatherForecast = [getData(fromIndex: 1), getData(fromIndex: 2), getData(fromIndex: 3), getData(fromIndex: 4), getData(fromIndex: 5), getData(fromIndex: 6), getData(fromIndex: tomorrowIndex + 12), getData(fromIndex: tomorrowIndex + 20), getData(fromIndex: tomorrowIndex + 28)]
        
        func getData(fromIndex index: Int) -> (String, Int) {
            return (anotherDayDateFormatter.string(from: dateFormatter.date(from: weatherForecast.list[index].dt_txt)!), Int(round(weatherForecast.list[index].main.temp - 273.15)))
        }
    }
}
