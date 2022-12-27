//
//  CinemaTypeModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

// MARK: - CinemaTypeModel
struct CinemaTypeModel: Codable {
    let cinemaType: [CinemaType]

    enum CodingKeys: String, CodingKey {
        case cinemaType = "CinemaType"
    }
}

// MARK: - CinemaType
struct CinemaType: Codable {
    let type, cinemaTypeDescription: String

    enum CodingKeys: String, CodingKey {
        case type
        case cinemaTypeDescription = "description"
    }
}
