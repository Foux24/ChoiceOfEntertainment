//
//  MainBuilderProtocol.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

protocol MainBuilderProtocol {
    var viewModelFactory: ViewModelsFactory { get }
    func buildChoiceOfEntertainmentScreen() -> ChoiceOfEntertainmentViewController
    func buildChoiceTypeCinemaScreen() -> CinemaRequestGenerationViewController
    func buildSelectingMovieQueryOptionScreeb(_ index: Int, _ VC: CinemaRequestGenerationViewController) -> SelectingMovieQueryOptionViewController
}
