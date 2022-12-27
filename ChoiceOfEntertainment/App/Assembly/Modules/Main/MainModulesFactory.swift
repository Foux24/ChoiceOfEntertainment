//
//  MainModulesFactory.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

final class ModulesFactory: MainBuilderProtocol {
    
    func buildChoiceOfEntertainmentScreen() -> ChoiceOfEntertainmentViewController {
        let controller = ChoiceOfEntertainmentViewController()
        return controller
    }
    
    func buildChoiceTypeCinemaScreen() -> ChoiceTypeCinemaViewController {
        let controller = ChoiceTypeCinemaViewController()
        return controller
    }
}
