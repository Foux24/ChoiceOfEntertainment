//
//  CinemaRequestGenerationViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

import UIKit
import Combine

// MARK: - CinemaRequestGenerationViewController
final class CinemaRequestGenerationViewController: UIViewController {

    // MARK: Public properties
    var dismiss: CompletionBlock?
    var nextScreen: ((CinemaListRequestDataModel) -> ())?
    var openPickerViewController: ((Int, CinemaRequestGenerationViewController) -> ())?
    var mainView: CinemaRequestGenerationView {
        return self.view as! CinemaRequestGenerationView
    }
    
    @Published var cinemaListDataModel = CinemaListRequestDataModel()
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()

    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = CinemaRequestGenerationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

// MARK: - Private
private extension CinemaRequestGenerationViewController {
    
    /// Binding
    func binding() {
        mainView.headerView.onTappedBackButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        mainView.onTappedButton
            .sink { [weak self] dataButton in
                guard let self = self else { return }
                self.openPickerViewController?(dataButton.indexButton, self)
            }.store(in: &bag)
        mainView.onTappedSearchButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.nextScreen?(self.cinemaListDataModel)
            }.store(in: &bag)
        $cinemaListDataModel
            .sink { [weak self] model in
                guard let self = self else { return }
                self.mainView.searchButton.isEnabledCustom(self.checkDataModel(model))
            }.store(in: &bag)
    }
    
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
