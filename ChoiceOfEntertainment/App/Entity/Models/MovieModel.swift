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
    
    static var placeholder: Self {
        return MovieModel(total: nil, totalPages: nil, items: [])
    }
}

// MARK: - Item
struct MovieItem: Codable {
    let kinopoiskID: Int?
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let genres: [Genre]
    let ratingKinopoisk: Double?
    let year: Int?
    let posterURLPreview: String?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case nameRu, nameEn, nameOriginal, genres, ratingKinopoisk, year
        case posterURLPreview = "posterUrlPreview"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}
