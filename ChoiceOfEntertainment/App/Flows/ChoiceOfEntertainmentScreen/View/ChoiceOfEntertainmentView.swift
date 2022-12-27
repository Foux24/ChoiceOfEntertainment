//
//  ChoiceOfEntertainmentView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit
import SnapKit
import Combine

// MARK: - ChoiceOfEntertainmentView
final class ChoiceOfEntertainmentView: UIView {
    
    // MARK: - Combine properties
    let onTappedCinemaButton = PassthroughSubject<Void, Never>()
    let onTappedBookButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Private Properties
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Что для вас найти ?"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let cinemaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Кино", for: .normal)
        button.backgroundColor = .whiteAlpha10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.whiteAlpha50.cgColor
        button.layer.cornerRadius = ChoiceOfEntertainmentParameters.heightButton / 2
        return button
    }()

    private let bookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Книгу", for: .normal)
        button.backgroundColor = .whiteAlpha10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.whiteAlpha50.cgColor
        button.layer.cornerRadius = ChoiceOfEntertainmentParameters.heightButton / 2
        return button
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
private extension ChoiceOfEntertainmentView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .appBackground
        addTargetsButtons()
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(descriptionLabel)
        addSubview(cinemaButton)
        addSubview(bookButton)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(100)
            make.leading.trailing.equalToSuperview()
        }
        cinemaButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-100)
            make.centerX.equalToSuperview()
            make.height.equalTo(ChoiceOfEntertainmentParameters.heightButton)
            make.width.equalTo(ChoiceOfEntertainmentParameters.widhtButton)
        }
        bookButton.snp.makeConstraints { make in
            make.top.equalTo(cinemaButton.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(ChoiceOfEntertainmentParameters.heightButton)
            make.width.equalTo(ChoiceOfEntertainmentParameters.widhtButton)
        }
    }
    
    /// Добавление таргетов кнопкам
    func addTargetsButtons() {
        cinemaButton.addTarget(self, action: #selector(cinemaButtonTapped), for: .touchUpInside)
        bookButton.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
    }
    
    /// Тап по кнопке Сinema Button
    @objc
    func cinemaButtonTapped() {
        onTappedCinemaButton.send()
    }
    
    /// Тап по кнопке Book Button
    @objc
    func bookButtonTapped() {
        onTappedBookButton.send()
    }
}
