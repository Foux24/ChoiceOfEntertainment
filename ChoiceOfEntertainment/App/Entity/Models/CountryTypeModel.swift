//
//  CountryTypeModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

// MARK: - CountryTypeModel
struct CountryTypeModel: Codable {
    let countryType: [CountryType]

    enum CodingKeys: String, CodingKey {
        case countryType = "CountryType"
    }
}

// MARK: - CountryType
struct CountryType: Codable {
    let id: Int
    let country: String
}
