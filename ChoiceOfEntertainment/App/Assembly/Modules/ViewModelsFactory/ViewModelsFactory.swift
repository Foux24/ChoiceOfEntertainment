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
}
