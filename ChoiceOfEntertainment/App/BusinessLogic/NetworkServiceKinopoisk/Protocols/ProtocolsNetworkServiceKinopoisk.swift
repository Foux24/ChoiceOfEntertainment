//
//  ProtocolsNetworkServiceKinopoisk.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 11.01.2023.
//

import Foundation
import Combine

protocol ProtocolFetchListMovie {
    func fetchListMovies(from endpoint: Endpoint) -> AnyPublisher<MovieModel, Never>
}

protocol ProtocolFetchDataMovie {
    func fetchDescriptionMovie(from endpoint: Endpoint) -> AnyPublisher<DescriptionMovieModel, Never>
    func fetchListShotsMovie(from endpoint: Endpoint) -> AnyPublisher<[URLsShotsFilmModel], Never>
}
