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
