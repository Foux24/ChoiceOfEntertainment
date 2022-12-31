//
//  CinemaRequestGenerationView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import SnapKit
import Combine

// MARK: - CinemaRequestGenerationView
final class CinemaRequestGenerationView: UIView {
    
    // MARK: - Combine properties
    let onTappedButton = PassthroughSubject<NameButtonsRequestGenerationViewModel, Never>()
    let onTappedSearchButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Private Properties
    private(set) lazy var headerView: CustomNaviHeaderView = {
        let view = CustomNaviHeaderView()
        view.titleLabel.text = "Кино"
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .clear
        stack.alignment = .center
        return stack
    }()
    
    private(set) lazy var searchButton: AppButtonTypeOne = {
        let button = AppButtonTypeOne()
        button.setTitle("Поиск", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.isEnabledCustom(false)
        return button
    }()
    
    /// Смена тайтла кнопке
    func changeTitleButton(_ index: Int, _ newTitle: String) {
            let button = self.stackView.arrangedSubviews[index] as! UIButton
            button.setTitle(newTitle, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Init
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addUIInView()
        setupConstreints()
        addButtonStackView()
        addTargetSearchButton()
    }
    
    /// - Parameter aDecoder: aDecoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Private
private extension CinemaRequestGenerationView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .appBackground
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(headerView)
        addSubview(stackView)
        addSubview(searchButton)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    /// Добавление кнопок в стек
    func addButtonStackView() {
        NameButtonsRequestGenerationViewModel.listNameButtons.forEach { dataButton in
            let choiceCinemaTypeButton: AppButtonTypeOne = {
                let button = AppButtonTypeOne()
                button.setTitle(dataButton.nameButton, for: .normal)
                button.setTitleColor(.whiteAlpha25, for: .normal)
                return button
            }()
            choiceCinemaTypeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(choiceCinemaTypeButton)
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        NameButtonsRequestGenerationViewModel.listNameButtons.forEach { dataButton in
            if dataButton.nameButton == sender.titleLabel?.text {
                onTappedButton.send(dataButton)
            }
        }
    }
    
    /// Добавление таргета кнопке поиск
    func addTargetSearchButton() {
        searchButton.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
    }
    
    @objc
    func actionSearch() {
        onTappedSearchButton.send()
    }
}
