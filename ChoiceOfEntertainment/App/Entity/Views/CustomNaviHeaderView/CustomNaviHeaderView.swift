//
//  CustomNaviHeaderView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import SnapKit
import Combine

// MARK: - CustomNaviHeaderView
final class CustomNaviHeaderView: UIView {
    
    // MARK: - Combine properties
    let onTappedBackButton = PassthroughSubject<Void, Never>()
    let onTappedMoreButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Private Properties
    private let view = UIView()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return button
    }()
    
    private(set) lazy var moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
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
private extension CustomNaviHeaderView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .clear
        addTargetsButtons()
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(view)
        addSubview(backButton)
        addSubview(moreButton)
        addSubview(titleLabel)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(CustomNaviHeaderViewParameters.heightView)
        }
        backButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(10)
            make.height.width.equalTo(CustomNaviHeaderViewParameters.heightAndWidhtBackButton)
        }
        moreButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
            make.height.width.equalTo(CustomNaviHeaderViewParameters.heightAndWidhtBackButton)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    /// Добавление таргетов кнопкам
    func addTargetsButtons() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        onTappedBackButton.send()
    }
    
    @objc
    func moreButtonTapped() {
        onTappedMoreButton.send()
    }
}
