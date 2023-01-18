//
//  DescriptionMovieViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import UIKit
import Combine

// MARK: - DescriptionMovieViewController
final class DescriptionMovieViewController: UIViewController {
    
    // MARK: Public properties
    var dismiss: CompletionBlock?
    var viewModel: DescriptionMovieViewModel
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: DescriptionMovieView {
        return self.view as! DescriptionMovieView
    }
    
    // MARK: Init
    init(viewModel: DescriptionMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = DescriptionMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

// MARK: - Private
private extension DescriptionMovieViewController {
    
    /// Binding
    func binding() {
        mainView.headerView.onTappedBackButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        viewModel.$descriptionModel
            .sink { [weak self] model in
                guard let self = self else { return }
                self.mainView.configurationView(
                    posterImageURL: model.posterURL ?? "",
                    nameMovie: self.viewModel.fetchNameMovies.fetchNameMovie(model.nameRu, model.nameEn, model.nameOriginal),
                    description: model.description ?? "")
            }.store(in: &bag)
    }
}
