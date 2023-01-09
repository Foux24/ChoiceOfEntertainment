//
//  SelectMovieView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit

final class SelectMovieView: UIView {
    
    // MARK: - Private Properties
    private(set) lazy var headerView: CustomNaviHeaderView = {
        let view = CustomNaviHeaderView()
        view.titleLabel.text = "Кино"
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
private extension SelectMovieView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .appBackground
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
}
