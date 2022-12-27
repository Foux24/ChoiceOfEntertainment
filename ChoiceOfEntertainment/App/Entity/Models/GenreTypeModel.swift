//
//  GenreTypeModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

// MARK: - GenreTypeModel
struct GenreTypeModel: Codable {
    let genreType: [GenreType]

    enum CodingKeys: String, CodingKey {
        case genreType = "GenreType"
    }
}

// MARK: - GenreType
struct GenreType: Codable {
    let id: Int
    let genre: String
}
