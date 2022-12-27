//
//  ChoiceOfEntertainmentViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import Combine

// MARK: - ChoiceOfEntertainmentViewController
final class ChoiceOfEntertainmentViewController: UIViewController {

    // MARK: Public properties
    var choiceTypeCinemaScreen: CompletionBlock?
    var choiceBookScreen: CompletionBlock?
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: ChoiceOfEntertainmentView {
        return self.view as! ChoiceOfEntertainmentView
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = ChoiceOfEntertainmentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

// MARK: - Private
private extension ChoiceOfEntertainmentViewController {
    
    /// Binding
    func binding() {
        mainView.onTappedCinemaButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.choiceTypeCinemaScreen?()
            }.store(in: &bag)
        mainView.onTappedBookButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.choiceBookScreen?()
            }.store(in: &bag)
    }
}
