//
//  Router.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

typealias RouterCompletions = [UIViewController: CompletionBlock]

final class Router: NSObject {
    fileprivate weak var rootController: UINavigationController?
    fileprivate var completions: RouterCompletions

    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    var toPresent: UIViewController? {
        return rootController
    }
}

private extension Router {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

extension Router: Routable {
    
    func presentAutomatic(_ module: Presentable?, animated: Bool, completion: (() -> Void)? = nil) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: completion)
    }

    func present(_ module: Presentable?) {
        presentFullScreen(module, animated: true)
    }

    func presentFullScreen(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .fullScreen
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func presentModally(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .popover
        if let popoverController = controller.popoverPresentationController {
            popoverController.sourceRect = CGRect(
                x: UIScreen.main.bounds.width / 2,
                y: UIScreen.main.bounds.height / 2,
                width: 0,
                height: 0)
            popoverController.sourceView = rootController?.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func presentOverCurrentContext(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .overCurrentContext
        if let popoverController = controller.popoverPresentationController {
            popoverController.sourceRect = CGRect(
                x: UIScreen.main.bounds.width / 2,
                y: UIScreen.main.bounds.height / 2,
                width: 0,
                height: 0)
            popoverController.sourceView = rootController?.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func presentFullScreenFromModalController(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .fullScreen
        if let presentedViewController = rootController?.presentedViewController {
            presentedViewController.present(controller, animated: animated, completion: nil)
        }
    }

    func presentFromRight(_ module: Presentable?) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut
        )
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        rootController?.view.window?.layer.add(transition, forKey: kCATransition)
        rootController?.present(controller, animated: false, completion: nil)
    }
    
    func presentFromBottom(_ module: Presentable?) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut
        )
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        rootController?.view.window?.layer.add(transition, forKey: kCATransition)
        rootController?.present(controller, animated: false, completion: nil)
    }

    func presentOverFullScreen(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .overFullScreen
        if let presentedViewController = rootController?.presentedViewController {
            presentedViewController.present(controller, animated: animated, completion: nil)
        }
    }
    
    func presentFromFrame(_ module: Presentable?, with delegate: UIViewControllerTransitioningDelegate) {
        guard let controller = module?.toPresent else { return }
        controller.modalPresentationStyle = .fullScreen
        controller.transitioningDelegate = delegate
        rootController?.present(controller, animated: true)
    }

    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
        else { assertionFailure("⚠️Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    func push(_ module: Presentable?, customTransition: Bool, duration: Double) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
        else { assertionFailure("⚠️Deprecated push UINavigationController."); return }
        if customTransition {
            let transition = CATransition()
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(
                name: CAMediaTimingFunctionName.easeInEaseOut
            )
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            rootController?.view.layer.add(transition, forKey: nil)
        }
        rootController?.pushViewController(controller, animated: false)
    }
    
    func push(_ module: Presentable?, fadeTransition: Bool, duration: Double) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
        else { assertionFailure("⚠️Deprecated push UINavigationController."); return }
        if fadeTransition {
            let transition = CATransition()
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(
                name: CAMediaTimingFunctionName.easeInEaseOut
            )
            transition.type = CATransitionType.fade
            rootController?.view.layer.add(transition, forKey: nil)
        }
        rootController?.pushViewController(controller, animated: false)
    }

    func popModule() {
        popModule(animated: true)
    }

    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popModule(customTransition: Bool, duration: Double, completion: CompletionBlock?) {
        if customTransition {
            let transition = CATransition()
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(
                name: CAMediaTimingFunctionName.easeInEaseOut
            )
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromBottom
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            rootController?.view.layer.add(transition, forKey: nil)
            CATransaction.commit()
        }
        rootController?.popViewController(animated: false)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func dismissModuleOneStepBack(animated: Bool, completion: CompletionBlock?) {
        if let presentedViewController = rootController?.presentedViewController {
            presentedViewController.dismiss(animated: animated, completion: completion)
        }
    }
    
    func dismissWithFadeTransition() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        transition.subtype = .fromTop
        rootController?.view.backgroundColor = .clear
        rootController?.view.window?.layer.backgroundColor = UIColor.clear.cgColor
        rootController?.view.window?.layer.add(transition, forKey: nil)
        rootController?.dismiss(animated: false, completion: nil)
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
        rootController?.modalPresentationStyle = .fullScreen
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    func setRoot(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
}
