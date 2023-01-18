//
//  SelectMovieViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit
import Combine

// MARK: - SelectMovieViewModel
final class SelectMovieViewModel {
    
    // MARK: - Public property
    let countSection: Int = 1
    var listMovie = [MovieItem]()
    var cacheImageService: CacheImageService?
    var isLoading: Bool = false
    var fetchNameMovies: ProtocolFetchNameMovies = FetchNameMovies()
    
    // input
    @Published var parametersRequest: CinemaListRequestDataModel
    @Published var numberPage: Int = 1
    // output
    @Published var movieModel = MovieModel(total: nil, totalPages: nil, items: [])
    
    // MARK: - Private property
    private var bag = Set<AnyCancellable>()
    private let networkService: ProtocolFetchListMovie = NetworkServiceKinopoisk()
    
    // MARK: - Init
    init(parametersRequest: CinemaListRequestDataModel) {
        self.parametersRequest = parametersRequest
        fetchListMovies()
    }
    
    /// Получение списка жанров в одной строке
    func fetchListGengre(genres: [Genre]) -> String {
        var stringGenre: String = ""
        genres.forEach { genre in
            stringGenre += " \(genre.genre),"
        }
        stringGenre.removeFirst()
        stringGenre.removeLast()
        return stringGenre.capitalized
    }
    
    /// Подгрузка новых фильмов в конец списка
    func loadMovies(indexPaths: [IndexPath]) -> Void {
        guard let maxRows = indexPaths.map({$0.row}).max() else { return }
        guard let totalPages = movieModel.totalPages else { return }
        let nextPage = numberPage + 1
        if maxRows > listMovie.count - 10, !isLoading && numberPage < totalPages {
            numberPage = nextPage
        }
    }
}

// MARK: - Private
private extension SelectMovieViewModel {
    
    /// Получение списка фильмов
    func fetchListMovies() {
        Publishers.CombineLatest( $parametersRequest, $numberPage)
            .flatMap { (parametersRequest, numberPage) -> AnyPublisher<MovieModel, Never> in
                self.isLoading = true
                return self.networkService.fetchListMovies(
                    from: Endpoint(
                        index: 0,
                        parameter: parametersRequest,
                        numberPage: numberPage)!)
            }
            .assign(to: \.movieModel, on: self)
            .store(in: &self.bag)
    }
}
