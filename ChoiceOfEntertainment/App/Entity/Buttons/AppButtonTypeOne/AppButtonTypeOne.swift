//
//  AppButtonTypeOne.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 29.12.2022.
//

import UIKit
import SnapKit

// MARK: - AppButtonTypeOne
final class AppButtonTypeOne: UIButton {
    
    // MARK: - Init
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    /// - Parameter aDecoder: aDecoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Настройки on/off кнопки
    func isEnabledCustom(_ isState: Bool) {
        switch isState {
        case true:
            self.isEnabled = true
            self.layer.opacity = 1.0
        case false:
            self.isEnabled = false
            self.layer.opacity = 0.2
        }
    }
}

// MARK: - Private
private extension AppButtonTypeOne {
    
    /// Настройка кнопки
    func setupButton() {
        self.backgroundColor = .whiteAlpha10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.whiteAlpha50.cgColor
        self.layer.cornerRadius = AppButtonTypeOneParameters.heightButton / 2
        self.snp.makeConstraints { make in
            make.width.equalTo(AppButtonTypeOneParameters.widhtButton)
            make.height.equalTo(AppButtonTypeOneParameters.heightButton)
        }
    }
}
