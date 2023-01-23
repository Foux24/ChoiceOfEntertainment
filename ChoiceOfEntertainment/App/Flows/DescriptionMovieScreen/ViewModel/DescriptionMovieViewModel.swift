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
    var cacheImageService: CacheImageService?
    var listShotsPreviewURLs = [String]()
    
    // input
    @Published var kinopoiskID: Int
    @Published var numberPageShotsMovie: Int = 0
    // output
    @Published var descriptionModel = DescriptionMovieModel.placeholder
    @Published var listPreviewURL = [URLsShotsFilmModel]()
    
    // MARK: - Private property
    private var bag = Set<AnyCancellable>()
    private let networkService: ProtocolFetchDataMovie = NetworkServiceKinopoisk()
    
    // MARK: - Init
    init(kinopoiskID: Int) {
        self.kinopoiskID = kinopoiskID
        self.numberPageShotsMovie = 1
        fetchDataMovie()
        fetchListPreviewURL()
    }
}

// MARK: - Private
private extension DescriptionMovieViewModel {
    
    /// Получение данных фильма
    func fetchDataMovie() {
        $kinopoiskID
            .flatMap { (kinopoiskID:Int) -> AnyPublisher <DescriptionMovieModel, Never> in
                return self.networkService.fetchDescriptionMovie(
                    from: Endpoint(index: 1, kinopoiskID: kinopoiskID)!)
            }
            .assign(to: \.descriptionModel , on: self)
            .store(in: &self.bag)
    }
    
    /// Получение кадров фильма
    func fetchListPreviewURL() {
        $numberPageShotsMovie
            .flatMap { (numberPageShotsMovie:Int) -> AnyPublisher <[URLsShotsFilmModel], Never> in
                return self.networkService.fetchListShotsMovie(from: Endpoint(index: 2, numberPage: numberPageShotsMovie, kinopoiskID: self.kinopoiskID)!)
            }
            .assign(to: \.listPreviewURL , on: self)
            .store(in: &self.bag)
    }
}
