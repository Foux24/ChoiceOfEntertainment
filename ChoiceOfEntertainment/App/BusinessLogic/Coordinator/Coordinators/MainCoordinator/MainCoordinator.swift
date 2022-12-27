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
        router.push(vc, animated: true)
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
