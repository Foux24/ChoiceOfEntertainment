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
    private(set) lazy var headerView: CustomNaviHeaderView = {
        let view = CustomNaviHeaderView()
        view.titleLabel.text = "1/5"
        return view
    }()
    
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
        addSubview(headerView)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    /// Добавление таргетов кнопкам
    func addTargetsButtons() {
    }
}
