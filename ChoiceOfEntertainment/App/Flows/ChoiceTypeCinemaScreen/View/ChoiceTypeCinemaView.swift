//
//  ChoiceTypeCinemaView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import SnapKit
import Combine

// MARK: - ChoiceTypeCinemaView
final class ChoiceTypeCinemaView: UIView {
    
    // MARK: - Combine properties
    
    // MARK: - Private Properties

    
    // MARK: - Init
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addUIInView()
        setupConstreints()
    }
    
    /// - Parameter aDecoder: aDecoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Private
private extension ChoiceTypeCinemaView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .appBackground
        addTargetsButtons()
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
    }
    
    /// Добавление таргетов кнопкам
    func addTargetsButtons() {
    }
}
