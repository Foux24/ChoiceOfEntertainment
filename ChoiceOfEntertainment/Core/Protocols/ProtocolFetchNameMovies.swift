//
//  ProtocolFetchNameMovies.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import Foundation

protocol ProtocolFetchNameMovies {}

extension ProtocolFetchNameMovies {
    /// Получение названия фильма
    func fetchNameMovie(_ nameRU: String?,_ nameEN: String?,_ nameOrig: String?) -> String {
        let noName: String = "noName"
        var nameMovie: String = ""
        if let ruName = nameRU {
            nameMovie = ruName
        } else if let enName = nameEN {
            nameMovie = enName
        } else if let origName = nameOrig {
            nameMovie = origName
        } else {
            nameMovie = noName
        }
        return nameMovie
    }
}

// MARK: - FetchNameMovies
final class FetchNameMovies: ProtocolFetchNameMovies {
    func fetchNameMovie(_ nameRU: String?,_ nameEN: String?,_ nameOrig: String?) -> String { return "" }
}
