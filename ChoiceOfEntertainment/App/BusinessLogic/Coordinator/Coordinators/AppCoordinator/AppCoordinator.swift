//
//  AppCoordinator.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router: Routable
    
    init(
        router: Routable,
        factory: CoordinatorFactoryProtocol,
        window: UIWindow?
    ) {
        self.router = router
        self.factory = factory
        self.window = window
        super.init()
        windowSettings()
    }
    
    class func build(
        router: Router,
        window: UIWindow?
    ) -> AppCoordinator {
        let factory = CoordinatorFactory()
        let appCoordinator = AppCoordinator(
            router: router,
            factory: factory,
            window: window
        )
        return appCoordinator
    }
    
    private func windowSettings() {
        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .black
    }
}

extension AppCoordinator: Coordinator {
    
    func start() {
        performMainFlow()
        window?.makeKeyAndVisible()
    }
    
    private func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(with: router)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
