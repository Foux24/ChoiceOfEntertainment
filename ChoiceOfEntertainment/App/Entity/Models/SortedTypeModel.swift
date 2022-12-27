//
//  SortedTypeModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

// MARK: - SortedTypeModel
struct SortedTypeModel: Codable {
    let sortedType: [SortedType]

    enum CodingKeys: String, CodingKey {
        case sortedType = "SortedType"
    }
}

// MARK: - SortedType
struct SortedType: Codable {
    let type, sortedTypeDescription: String

    enum CodingKeys: String, CodingKey {
        case type
        case sortedTypeDescription = "description"
    }
}
