//
//  News.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import Foundation

struct News: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

struct Article: Decodable {
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct Source: Decodable {
    var id: String?
    var name: String?
}
