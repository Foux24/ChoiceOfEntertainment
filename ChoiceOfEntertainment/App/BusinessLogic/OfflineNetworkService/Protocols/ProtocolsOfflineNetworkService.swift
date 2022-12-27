//
//  ProtocolsOfflineNetworkService.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

/// Протокол для получения списка типов фильмов
protocol ProtocolFetchListCinemaType {
    func fetchListCinemaType(_ nameFile: String, completion: @escaping (CinemaTypeModel) -> Void)
}
