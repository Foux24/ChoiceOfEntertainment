//
//  DescriptionMovieModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import Foundation

// MARK: - DescriptionMovieModel
struct DescriptionMovieModel: Codable {
    let kinopoiskID: Int
    let nameRu, nameEn, nameOriginal, posterURL: String?
    let ratingKinopoisk: Double?
    let ratingKinopoiskVoteCount: Int?
    let webURL: String?
    let slogan, description, shortDescription: String?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case nameRu, nameEn, nameOriginal
        case posterURL = "posterUrl"
        case ratingKinopoisk, ratingKinopoiskVoteCount
        case webURL = "webUrl"
        case slogan, description, shortDescription
    }
    
    static var placeholder: Self {
        return DescriptionMovieModel(kinopoiskID: 0, nameRu: nil, nameEn: nil, nameOriginal: nil, posterURL: nil, ratingKinopoisk: nil, ratingKinopoiskVoteCount: nil, webURL: nil, slogan: nil, description: nil, shortDescription: nil)
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}
