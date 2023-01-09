//
//  SelectMovieViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit
import Combine

// MARK: - SelectMovieViewController
final class SelectMovieViewController: UIViewController {
    
    // MARK: Public properties
    var dismiss: CompletionBlock?
    var viewModel: SelectMovieViewModel
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: SelectMovieView {
        return self.view as! SelectMovieView
    }
    
    // MARK: Init
    init(viewModel: SelectMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = SelectMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

private extension SelectMovieViewController {
    
    /// Binding
    func binding() {
        mainView.headerView.onTappedBackButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
    }
}
