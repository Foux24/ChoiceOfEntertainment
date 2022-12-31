//
//  RequestParameterConstructor.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

/// Исходящий протокол конструктора
protocol ProtocolRequestParameterConstructorOutput {
    func fetchParametrs(_ index: Int) -> [String:String]
}

// MARK: - RequestParameterConstructor
final class RequestParameterConstructor {
    
    // MARK: - Private properties
    private let data = Data()
    private let decoder = JSONDecoder()
}

// MARK: - Extension RequestParameterConstructor on the ProtocolRequestParameterConstructorOutput
extension RequestParameterConstructor: ProtocolRequestParameterConstructorOutput {
    
    /// Получения списка параметров
    /// - Parameter index: Индекс для определения списка параметра
    func fetchParametrs(_ index: Int) -> [String:String] {
        configDictionaryParameters(index)
    }
}

// MARK: - Private
private extension RequestParameterConstructor {
    
    /// Получение списка типов кино
    /// - Parameter index: Индекс для определения списка параметра
    func configDictionaryParameters(_ index: Int) -> [String:String] {
        var dicResult = [String:String]()
        switch index {
        case 0:
            dicResult = configDictionaryFileNameJSON(.cinema)
        case 1:
            dicResult = configDictionaryFileNameJSON(.country)
        case 2:
            dicResult = configDictionaryFileNameJSON(.genre)
        case 3:
            dicResult = configDictionaryFileNameJSON(.sorted)
        case 4,5:
            dicResult = configDictionaryRating()
        case 6,7:
            dicResult = configDictionaryYear()
        default: break
        }
        return dicResult
    }
    
    /// Конфигурация словаря по переданному имени JSON файла
    func configDictionaryFileNameJSON(_ typeEnum: EnumNameFilesJSONCinemaParameter) -> [String: String] {
        var dicResult = [String:String]()
        let data = data.loadDataJson(typeEnum.rawValue)
        switch typeEnum {
        case .cinema:
            guard let result = try? decoder.decode(CinemaTypeModel.self, from: data).cinemaType
            else {
                return [:]
            }
            result.forEach { type in
                dicResult[type.typeDescription] = type.typeRequest
            }
        case .sorted:
            guard let result = try? decoder.decode(SortedTypeModel.self, from: data).sortedType
            else {
                return [:]
            }
            result.forEach { type in
                dicResult[String(type.typeDescription)] = type.typeRequest
            }
        case .country:
            guard let result = try? decoder.decode(CountryTypeModel.self, from: data).countryType
            else {
                return [:]
            }
            result.forEach { type in
                dicResult[type.country] = String(type.id)
            }
        case .genre:
            guard let result = try? decoder.decode(GenreTypeModel.self, from: data).genreType
            else {
                return [:]
            }
            result.forEach { type in
                dicResult[type.genre] = String(type.id)
            }
        }
        return dicResult
    }
    
    /// Кнфигурация словаря с рейтингом
    func configDictionaryRating() -> [String: String] {
        var dicResult = [String:String]()
        for rating in 0...10 {
            dicResult[String(rating)] = String(rating)
        }
        return dicResult
    }
    
    /// Конфигурация словаря со списком годов
    func configDictionaryYear() -> [String: String] {
        var dicResult = [String:String]()
        for year in 1980...getCurrentYear() {
            dicResult[String(year)] = String(year)
        }
        return dicResult
    }
    
    /// Получение текущего года
    func getCurrentYear() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let year = calendar.date(byAdding: .year, value: 0, to: Date().localDate())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        guard let year = Int(dateFormatter.string(from: year!)) else { return 0 }
        return year
    }
}
