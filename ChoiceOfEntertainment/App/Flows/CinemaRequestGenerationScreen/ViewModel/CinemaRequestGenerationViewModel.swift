//
//  CinemaRequestGenerationViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 31.12.2022.
//

import Foundation

// MARK: - CinemaRequestGenerationViewModel
final class CinemaRequestGenerationViewModel {
    
    // MARK: - Combine property
    @Published var cinemaListDataModel = CinemaListRequestDataModel()
    
    // MARK: - Public Funcs
    /// Проверка данных для включения кнопки поиска
    func checkDataModel(_ model: CinemaListRequestDataModel) -> Bool {
        if model.typeCinema != nil &&
            model.typeCountry != nil &&
            model.genre != nil &&
            model.typeSorted != nil &&
            model.ratingMin != nil &&
            model.ratingMax != nil &&
            model.yearMin != nil &&
            model.yearMax != nil {
            return true
        } else {
            return false
        }
    }
}
