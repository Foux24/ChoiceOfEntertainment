//
//  MovieModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let total, totalPages: Int?
    let items: [MovieItem]
}

// MARK: - Item
struct MovieItem: Codable {
    let kinopoiskID: Int?
    let imdbID: String?
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let countries: [Country]
    let genres: [Genre]
    let ratingKinopoisk: Double?
    let ratingImdb: Double?
    let year: Int?
    let type: String?
    let posterURL, posterURLPreview: String?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case imdbID = "imdbId"
        case nameRu, nameEn, nameOriginal, countries, genres, ratingKinopoisk, ratingImdb, year, type
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}
