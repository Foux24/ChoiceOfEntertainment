//
//  BlurredView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import UIKit

class BlurredView: UIVisualEffectView {
    
    private var animator: UIViewPropertyAnimator?
    private let blurEffect: UIVisualEffect
    private let blurIntensity: CGFloat
    
    init(intensity: CGFloat) {
        let effect = UIBlurEffect(style: .dark)
        blurEffect = effect
        blurIntensity = intensity
        super.init(effect: nil)
      }

    required init?(coder aDecoder: NSCoder) {
            fatalError()
        }

      deinit {
        animator?.stopAnimation(true)
      }

      override func draw(_ rect: CGRect) {
        super.draw(rect)
        effect = nil
        animator?.stopAnimation(true)
          animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
          self.effect = blurEffect
        }
          animator?.pausesOnCompletion = true
        animator?.fractionComplete = blurIntensity
      }
}
