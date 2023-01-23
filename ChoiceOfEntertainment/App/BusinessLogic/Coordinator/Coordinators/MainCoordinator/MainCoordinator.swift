//
//  MainCoordinator.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import Combine

/// Исходящий протокол координатора
protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

// MARK: - MainCoordinator
final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: MainBuilderProtocol
    
    fileprivate var mainScreenView: ChoiceOfEntertainmentViewController
    
    fileprivate let router: Routable
    
    private let coordinatorFactory: CoordinatorFactory

    init(router: Routable, factory: MainBuilderProtocol) {
        self.router = router
        self.factory = factory
        self.mainScreenView = factory.buildChoiceOfEntertainmentScreen()
        self.coordinatorFactory = CoordinatorFactory()
        super.init()
        start()
    }
}

// MARK: - MainCoordinator on the Coordinator
extension MainCoordinator: Coordinator {
    
    /// Старт формирования экрана
    func start() {
        runChoiceOfEntertainmentScreen()
    }
}

// MARK: - Private
private extension MainCoordinator {
    
    func runChoiceOfEntertainmentScreen() {
        mainScreenView.choiceTypeCinemaScreen = { [weak self] in
            guard let self = self else { return }
            self.runChoiceTypeCinemaScreen()
        }
        mainScreenView.choiceBookScreen = { [weak self] in
            guard let self = self else { return }
            print("runChoiceBookScreen")
        }
        router.setRootModule(mainScreenView, hideBar: true)
    }
    
    func runChoiceTypeCinemaScreen() {
        let vc = factory.buildChoiceTypeCinemaScreen()
        vc.dismiss = { [weak self] in
            guard let self = self else { return }
            self.popModule()
        }
        vc.moreButton = { [weak self] in
            guard let self = self else { return }
            self.runLastSearchesScreen()
        }
        vc.openPickerViewController = { [weak self] (indexButton, viewController) in
            guard let self = self else { return }
            self.runSelectingMovieQueryOptionScreen(indexButton, viewController)
        }
        vc.nextScreen = { [weak self] parametersRequest in
            guard let self = self else { return }
            self.runSelectMovieViewScreen(parametersRequest)
        }
        router.push(vc, animated: true)
    }
    
    func runSelectingMovieQueryOptionScreen(_ index: Int, _ VC: CinemaRequestGenerationViewController) {
        let vc = factory.buildSelectingMovieQueryOptionScreeb(index, VC)
        vc.dismiss = { [weak self] in
            guard let self = self else { return }
            self.dismiss()
        }
        router.presentOverCurrentContext(vc, animated: true)
    }
    
    func runSelectMovieViewScreen(_ parametersRequest: CinemaListRequestDataModel) {
        let vc = factory.buildSelectMovieViewScreen(parametersRequest)
        vc.dismiss = { [weak self] in
            guard let self = self else { return }
            self.popModule()
        }
        vc.onDescriptionMovie = { [weak self] kinopoiskID in
            guard let self = self else { return }
            self.runDescriptionMovieScreen(kinopoiskID)
        }
        router.push(vc, animated: true)
    }
    
    func runDescriptionMovieScreen(_ kinopoiskID: Int) {
        let vc = factory.buildDescriptionMovieScreen(kinopoiskID)
        vc.dismiss = { [weak self] in
            guard let self = self else { return }
            self.popModuleToBottom()
        }
        router.push(vc, animated: true)
    }
    
    func runLastSearchesScreen() {
        let vc = factory.buildLastFiveSearchesScreen()
        vc.dismiss = { [weak self] in
            guard let self = self else { return }
            self.dismiss()
        }
        vc.nextScreen = { [weak self] parametersRequest in
            guard let self = self else { return }
            self.runSelectMovieViewScreen(parametersRequest)
        }
        router.presentOverCurrentContext(vc, animated: true)
    }
    
    func popModule() {
        router.popModule()
    }
    
    func popModuleToBottom() {
        router.popModule(customTransition: true, duration: 0.4, completion: nil)
    }
    
    func dismiss() {
        router.dismissModule()
    }
    
    func popToRoot() {
        router.popToRootModule(animated: false)
    }
    
    func popToBottomToRoot() {
        router.popModule(customTransition: true, duration: 0.4, completion: nil)
        router.popToRootModule(animated: false)
    }

    func setMainAsRoot() {
        router.setRoot(mainScreenView, hideBar: true)
    }
}
