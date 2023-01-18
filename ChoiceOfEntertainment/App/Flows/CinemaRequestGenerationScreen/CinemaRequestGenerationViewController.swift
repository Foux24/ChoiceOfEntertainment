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
    var moreButton: CompletionBlock?
    var nextScreen: ((CinemaListRequestDataModel) -> ())?
    var openPickerViewController: ((Int, CinemaRequestGenerationViewController) -> ())?
    
    var viewModel: CinemaRequestGenerationViewModel
    
    var mainView: CinemaRequestGenerationView {
        return self.view as! CinemaRequestGenerationView
    }
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    
    // MARK: Init
    init(viewModel: CinemaRequestGenerationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        
        mainView.headerView.onTappedMoreButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.moreButton?()
            }.store(in: &bag)
        
        mainView.onTappedButton
            .sink { [weak self] dataButton in
                guard let self = self else { return }
                self.openPickerViewController?(dataButton.indexButton, self)
            }.store(in: &bag)
        
        mainView.onTappedSearchButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                let coreData = CoreDataManager.instance
                coreData.createListPropertiesRequestCD(properties: self.viewModel.cinemaListDataModel)
                self.nextScreen?(self.viewModel.cinemaListDataModel)
            }.store(in: &bag)
        
        viewModel.$cinemaListDataModel
            .sink { [weak self] dataModel in
                guard let self = self else { return }
                let isChekDataModel = self.viewModel.checkDataModel(dataModel)
                self.mainView.searchButton.isEnabledCustom(isChekDataModel)
            }.store(in: &bag)
    }
}
