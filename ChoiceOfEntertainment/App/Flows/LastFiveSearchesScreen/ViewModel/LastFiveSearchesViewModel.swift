//
//  LastFiveSearchesViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//

import Foundation
import Combine

final class LastFiveSearchesViewModel {
    
    // MARK: - Public properties
    @Published var listSearches: [ModelRequestMoviesCD] = {
        let coreData = CoreDataManager.instance
        return coreData.propertiesRequestMovies ?? []
    }()
    var listProperties: CinemaListRequestDataModel?
    
    // MARK: - Private Property
    private let constructorParameters: ProtocolRequestParameterConstructorOutput = RequestParameterConstructor()
    
    func convertCDModel(_ modelCD: ModelRequestMoviesCD) -> CinemaListRequestDataModel {
        CinemaListRequestDataModel(
            typeCinema: modelCD.typeCinema,
            typeCountry: modelCD.typeCountry,
            genre: modelCD.genre,
            typeSorted: modelCD.typeSorted,
            ratingMin: modelCD.ratingMin,
            ratingMax: modelCD.ratingMax,
            yearMin: modelCD.yearMin,
            yearMax: modelCD.yearMax)
    }
    
    func fetchNameParameter(index: Int, nameParameter: String) -> String {
        var name: String = ""
        constructorParameters.fetchParametrs(index).forEach { key,value in
            if value == nameParameter {
                name = key
            }
        }
        return name
    }
}

private extension LastFiveSearchesViewModel {
    
}
