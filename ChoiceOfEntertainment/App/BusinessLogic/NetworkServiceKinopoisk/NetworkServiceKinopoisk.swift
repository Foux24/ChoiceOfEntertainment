//
//  NetworkServiceKinopoisk.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit
import Combine

/// Enum с конечной точкой запроса
enum Endpoint {
    
    case searchMovieFilters(_ parameter: CinemaListRequestDataModel, _ numberPage: String)
    
    var baseURL:URL {URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/")!}
    
    /// Путь URL
    func path() -> String {
        switch self {
        case .searchMovieFilters:
            return "films"
        }
    }
    
    var absoluteURL: URLRequest? {
        let queryURL = baseURL.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        switch self {
        case .searchMovieFilters(let parameter, let numberPage):
            urlComponents.queryItems = [URLQueryItem(name: "countries", value: parameter.typeCountry),
                                        URLQueryItem(name: "genres", value: parameter.genre),
                                        URLQueryItem(name: "order", value: parameter.typeSorted),
                                        URLQueryItem(name: "type", value: parameter.typeCinema),
                                        URLQueryItem(name: "ratingFrom", value: parameter.ratingMin),
                                        URLQueryItem(name: "ratingTo", value: parameter.ratingMax),
                                        URLQueryItem(name: "yearFrom", value: parameter.yearMin),
                                        URLQueryItem(name: "yearTo", value: parameter.yearMax),
                                        URLQueryItem(name: "page", value: numberPage),
            ]
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue(APIConstants.kinoApiKey, forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        return request
    }
    
    // MARK: - Init
    init? (index: Int, parameter: CinemaListRequestDataModel = CinemaListRequestDataModel(), numberPage: Int = 1) {
        switch index {
        case 0: self = .searchMovieFilters(parameter, String(numberPage))
        default: return nil
        }
    }
}

// MARK: - NetworkServiceKinopoisk
final class NetworkServiceKinopoisk: ProtocolFetchListMovie {
    
    /// Получение списка фильмов
    func fetchListMovies(from endpoint: Endpoint) -> AnyPublisher<MovieModel, Never> {
        let nilModel = MovieModel(total: nil, totalPages: nil, items: [])
        guard let url = endpoint.absoluteURL else {
            return Just(nilModel).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: MovieModel) -> MovieModel in
                return response }
            .replaceError(with: nilModel)
            .eraseToAnyPublisher()
    }
}

// MARK: - Private
private extension NetworkServiceKinopoisk {
    
    /// Асинхронная выборка на основе URL
    func fetch<T: Decodable>(_ url: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
