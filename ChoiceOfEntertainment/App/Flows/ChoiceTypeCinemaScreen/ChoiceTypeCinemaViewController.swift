//
//  ChoiceTypeCinemaViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

import UIKit
import Combine

// MARK: - ChoiceTypeCinemaViewController
final class ChoiceTypeCinemaViewController: UIViewController {

    // MARK: Public properties
//    var choiceTypeCinemaScreen: CompletionBlock?
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: ChoiceTypeCinemaView {
        return self.view as! ChoiceTypeCinemaView
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = ChoiceTypeCinemaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
}

// MARK: - Private
private extension ChoiceTypeCinemaViewController {
    
    /// Binding
    func binding() {
//        mainView.onTappedCinemaButton
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//                self.choiceTypeCinemaScreen?()
//            }.store(in: &bag)
//        mainView.onTappedBookButton
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//                self.choiceBookScreen?()
//            }.store(in: &bag)
    }
}
