//
//  WeatherForecast.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 02.05.2022.
//

import Foundation

struct WeatherForecast: Decodable {
    var list: [List]
    var city: CityInfo
}

struct List: Decodable {
    var main: Main
    var weather: [Weather]
    var dt_txt: String
}

struct CityInfo: Decodable {
    var id: Int
    var name: String
    var country: String
}

struct Coordinates: Decodable {
    var lat: Float
    var lon: Float
}

struct Main:Decodable {
    var temp: Float
    var feels_like: Float
    var temp_min: Float
    var temp_max: Float
    var pressure: Int
    var humidity: Int
    var temp_kf: Float
    
}

struct Weather:Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Clouds: Decodable {
    var all: Int
}

struct Wind:Decodable {
    var speed: Float
    var deg: Int
    var gust: Float
}

struct Sys: Decodable {
    var pod: String
}
