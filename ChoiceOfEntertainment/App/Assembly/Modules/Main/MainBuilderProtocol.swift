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
    func buildSelectMovieViewScreen(_ parametersRequest: CinemaListRequestDataModel) -> SelectMovieViewController
    func buildDescriptionMovieScreen(_ kinopoiskID: Int) -> DescriptionMovieViewController
    func buildLastFiveSearchesScreen() -> LastFiveSearchesViewController
}
