//
//  Routable.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

typealias CompletionBlock = (() -> Void)

protocol Routable: Presentable {

    func presentModally(_ module: Presentable?, animated: Bool)
    func presentOverCurrentContext(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?)
    func presentFullScreen(_ module: Presentable?, animated: Bool)
    func presentFromRight(_ module: Presentable?)
    func presentFromBottom(_ module: Presentable?)
    func presentOverFullScreen(_ module: Presentable?, animated: Bool)
    func presentFullScreenFromModalController(_ module: Presentable?, animated: Bool)
    func presentFromFrame(_ module: Presentable?, with delegate: UIViewControllerTransitioningDelegate)
    func presentAutomatic(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    func push(_ module: Presentable?, customTransition: Bool, duration: Double)
    func push(_ module: Presentable?, fadeTransition: Bool, duration: Double)

    func popModule()
    func popModule(animated: Bool)
    func popModule(customTransition: Bool, duration: Double, completion: CompletionBlock?)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    func dismissModuleOneStepBack(animated: Bool, completion: CompletionBlock?)
    func dismissWithFadeTransition()

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func setRoot(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
}
