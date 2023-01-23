//
//  ListShotsFilmModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 20.01.2023.
//

import Foundation

// MARK: - ListPreviewURL
struct ListURLsShotsFilmModel: Codable {
    let total, totalPages: Int
    let items: [URLsShotsFilmModel]
}

// MARK: - Item
struct URLsShotsFilmModel: Codable {
    let imageURL, previewURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case previewURL = "previewUrl"
    }
}
