//
//  ViewModelsFactory.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 30.12.2022.
//

import Foundation

// MARK: - ViewModelsFactory
final class ViewModelsFactory {

    /// Build ViewModel для экрана выбора параметра
    func buildSelectingMovieQueryOptionViewModel(_ index: Int, _ vc: CinemaRequestGenerationViewController) -> SelectingMovieQueryOptionViewModel {
        let viewModel = SelectingMovieQueryOptionViewModel(indexButton: index)
        viewModel.cinemaRequestGenerationViewController = vc
        return viewModel
    }
    
    /// Build ViewModel для экрана составления параметров
    func buildCinemaRequestGenerationViewModel() -> CinemaRequestGenerationViewModel {
        let viewModel = CinemaRequestGenerationViewModel()
        return viewModel
    }
    
    /// Build ViewModel для экрана выбора фильма
    func buildSelectMovieViewModel(_ parametersRequest: CinemaListRequestDataModel) -> SelectMovieViewModel {
        let viewModel = SelectMovieViewModel(parametersRequest: parametersRequest)
        return viewModel
    }
    
    /// Build ViewModel для экрана описания фильма фильма
    func buildDescriptionMovieViewModel(_ kinopoiskID: Int) -> DescriptionMovieViewModel {
        let viewModel = DescriptionMovieViewModel(kinopoiskID: kinopoiskID)
        return viewModel
    }
    
    /// Build ViewModel для экрана с последними 5-ю поисками
    func buildLastFiveSearchesViewModel() -> LastFiveSearchesViewModel {
        let viewModel = LastFiveSearchesViewModel()
        return viewModel
    }
}
