//
//  MainModulesFactory.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

final class ModulesFactory: MainBuilderProtocol {
    
    var viewModelFactory: ViewModelsFactory {
        return ViewModelsFactory()
    }
    
    func buildChoiceOfEntertainmentScreen() -> ChoiceOfEntertainmentViewController {
        let controller = ChoiceOfEntertainmentViewController()
        return controller
    }
    
    func buildChoiceTypeCinemaScreen() -> CinemaRequestGenerationViewController {
        let viewModel = viewModelFactory.buildCinemaRequestGenerationViewModel()
        let controller = CinemaRequestGenerationViewController(viewModel: viewModel)
        return controller
    }
    
    func buildSelectingMovieQueryOptionScreeb(_ index: Int, _ VC: CinemaRequestGenerationViewController) -> SelectingMovieQueryOptionViewController {
        let viewModel = viewModelFactory.buildSelectingMovieQueryOptionViewModel(index, VC)
        let controller = SelectingMovieQueryOptionViewController(viewModel: viewModel)
        return controller
    }
}
