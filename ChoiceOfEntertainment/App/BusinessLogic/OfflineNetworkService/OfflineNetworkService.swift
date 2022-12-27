//
//  OfflineNetworkService.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

// MARK: - OfflineNetworkService
final class OfflineNetworkService {
    
    // MARK: - Private properties
    private let data = Data()
    private let decoder = JSONDecoder()
}

// MARK: - Extension OfflineNetworkService on the Protocols
extension OfflineNetworkService: ProtocolFetchListCinemaType {
    
    /// Получение списка типов кино
    /// - Parameter nameFile: Имя файла JSON из папки Reusurse
    /// - Completion: - Блок обрабатывающий результат парсинга
    func fetchListCinemaType(_ nameFile: String, completion: @escaping (CinemaTypeModel) -> Void) {
        let data = data.loadDataJson(nameFile)
        do {
            let result = try decoder.decode(CinemaTypeModel.self, from: data)
            completion(result)
        } catch {
            print("No Data Parse")
        }
    }
}
