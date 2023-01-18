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
    let nameRu, nameEn, nameOriginal, posterURL, posterURLPreview, coverURL, logoURL: String?
    let reviewsCount: Int?
    let ratingGoodReview: Double?
    let ratingGoodReviewVoteCount: Int?
    let ratingKinopoisk: Double?
    let ratingKinopoiskVoteCount: Int?
    let ratingImdb: Double?
    let ratingImdbVoteCount: Int?
    let ratingFilmCritics: Int?
    let ratingFilmCriticsVoteCount: Int?
    let ratingAwait: Int?
    let ratingAwaitCount: Int?
    let ratingRFCritics: Int?
    let ratingRFCriticsVoteCount: Int?
    let webURL: String?
    let year, filmLength: Int?
    let slogan, description, shortDescription: String?
    let isTicketsAvailable: Bool?
    let type: String?
    let ratingAgeLimits: String?
    let countries: [Country]
    let genres: [Genre]
    let serial, shortFilm, completed, hasImax: Bool?
    let has3D: Bool?
    let lastSync: String?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case nameRu, nameEn, nameOriginal
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case coverURL = "coverUrl"
        case logoURL = "logoUrl"
        case reviewsCount, ratingGoodReview, ratingGoodReviewVoteCount, ratingKinopoisk, ratingKinopoiskVoteCount, ratingImdb, ratingImdbVoteCount, ratingFilmCritics, ratingFilmCriticsVoteCount, ratingAwait, ratingAwaitCount
        case ratingRFCritics = "ratingRfCritics"
        case ratingRFCriticsVoteCount = "ratingRfCriticsVoteCount"
        case webURL = "webUrl"
        case year, filmLength, slogan, description, shortDescription, isTicketsAvailable, type
        case ratingAgeLimits, countries, genres, serial, shortFilm, completed, hasImax, has3D, lastSync
    }
    
    static var placeholder: Self {
        return DescriptionMovieModel(kinopoiskID: 0, nameRu: nil, nameEn: nil, nameOriginal: nil, posterURL: nil, posterURLPreview: nil, coverURL: nil, logoURL: nil, reviewsCount: nil, ratingGoodReview: nil, ratingGoodReviewVoteCount: nil, ratingKinopoisk: nil, ratingKinopoiskVoteCount: nil, ratingImdb: nil, ratingImdbVoteCount: nil, ratingFilmCritics: nil, ratingFilmCriticsVoteCount: nil, ratingAwait: nil, ratingAwaitCount: nil, ratingRFCritics: nil, ratingRFCriticsVoteCount: nil, webURL: nil, year: nil, filmLength: nil, slogan: nil, description: nil, shortDescription: nil, isTicketsAvailable: nil, type: nil, ratingAgeLimits: nil, countries: [], genres: [], serial: nil, shortFilm: nil, completed: nil, hasImax: nil, has3D: nil, lastSync: nil)
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}
