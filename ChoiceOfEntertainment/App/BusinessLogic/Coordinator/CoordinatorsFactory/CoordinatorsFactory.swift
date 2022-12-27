//
//  CoordinatorsFactory.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeMainCoordinator(with router: Routable) -> Coordinator
    & MainCoordinatorOutput
}

final class CoordinatorFactory {
    private lazy var modulesFactory = ModulesFactory()
}
 
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeMainCoordinator(with router: Routable) -> Coordinator
    & MainCoordinatorOutput {
        return MainCoordinator(router: router, factory: modulesFactory)
    }
}
