//
//  DescriptionMovieViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import UIKit
import Combine

// MARK: - DescriptionMovieViewModel
final class DescriptionMovieViewModel {
    
    // MARK: - Public property
    var fetchNameMovies: ProtocolFetchNameMovies = FetchNameMovies()
    
    // input
    @Published var kinopoiskID: Int
    // output
    @Published var descriptionModel = DescriptionMovieModel.placeholder
    
    // MARK: - Private property
    private var bag = Set<AnyCancellable>()
    private let networkService: ProtocolFetchDescriptionMovie = NetworkServiceKinopoisk()
    
    // MARK: - Init
    init(kinopoiskID: Int) {
        self.kinopoiskID = kinopoiskID
        сonvertingModel()
    }
}

// MARK: - Private
private extension DescriptionMovieViewModel {
    
    /// Конвертируем модель
    func сonvertingModel() {
        $kinopoiskID
            .flatMap { (kinopoiskID:Int) -> AnyPublisher <DescriptionMovieModel, Never> in
                return self.networkService.fetchDescriptionMovie(
                    from: Endpoint(index: 1, kinopoiskID: kinopoiskID)!)
            }
            .assign(to: \.descriptionModel , on: self)
            .store(in: &self.bag)
    }
}
