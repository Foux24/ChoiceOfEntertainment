//
//  SelectMovieViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit
import Combine

final class SelectMovieViewModel {
    
    // MARK: - Public property
    // input
    @Published var parametersRequest: CinemaListRequestDataModel
    // output
    @Published var listMovie = [String]()
    
    // MARK: - Private property
    private var bag = Set<AnyCancellable>()
    
    init(parametersRequest: CinemaListRequestDataModel) {
        self.parametersRequest = parametersRequest
        requestListMovies()
    }
}

// MARK: - Private
private extension SelectMovieViewModel {
    func requestListMovies() {
        $parametersRequest
        fetchNonOptionalsParameters(parametersRequest) { typeCinema, typeCountry, genre, typeSorted, ratingMin, ratingMax, yearMin, yearMax in
            print(typeCinema, typeCountry, genre, typeSorted, ratingMin, ratingMax, yearMin, yearMax)
        }
    }
    
    func fetchNonOptionalsParameters(_ parameters: CinemaListRequestDataModel, completion: @escaping (_ typeCinema: String, _ typeCountry: String, _ genre: String, _ typeSorted: String, _ ratingMin: String, _ ratingMax: String, _ yearMin: String, _ yearMax: String) -> Void) {
        guard let typeCinema = parameters.typeCinema,
              let typeCountry = parameters.typeCountry,
              let genre = parameters.genre,
              let typeSorted = parameters.typeSorted,
              let ratingMin = parameters.ratingMin,
              let ratingMax = parameters.ratingMax,
              let yearMin = parameters.yearMin,
              let yearMax = parameters.yearMax
        else { return }
        completion(typeCinema, typeCountry, genre, typeSorted, ratingMin, ratingMax, yearMin, yearMax)
    }
}
