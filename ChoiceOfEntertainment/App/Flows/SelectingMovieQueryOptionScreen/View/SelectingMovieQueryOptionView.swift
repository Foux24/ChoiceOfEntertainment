//
//  SelectingMovieQueryOptionView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 30.12.2022.
//

import UIKit
import Combine

final class SelectingMovieQueryOptionView: UIView {
    
    // MARK: - Combine Property
    let onTappedSaveButton = PassthroughSubject<Void, Never>()
    let onTappedCancleButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Private property
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private(set) lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.cornerRadius = 20
        return picker
    }()
    
    private let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let pickerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pickerViewBackground
        return view
    }()
    
    private let demarcationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha50
        return view
    }()
    
    // MARK: - Init
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addUIInView()
        setupConstreints()
        addTargetsInUI()

    }
    
    /// - Parameter aDecoder: aDecoder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Private
private extension SelectingMovieQueryOptionView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .clear
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(clearView)
        addSubview(pickerView)
        
        pickerView.addSubview(cancleButton)
        pickerView.addSubview(saveButton)
        pickerView.addSubview(demarcationLine)
        pickerView.addSubview(picker)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        clearView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        pickerView.snp.makeConstraints { make in
            make.top.equalTo(clearView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(picker.frame.height + 45)
        }
        demarcationLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        picker.snp.makeConstraints { make in
            make.top.equalTo(demarcationLine.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        cancleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    /// Добавление таргетов на UI
    func addTargetsInUI() {
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        cancleButton.addTarget(self, action: #selector(tappedCancleButton), for: .touchUpInside)
        
        let tapToClearView = UITapGestureRecognizer(target: self, action: #selector(tappedClearView))
        clearView.addGestureRecognizer(tapToClearView)
        clearView.isUserInteractionEnabled = true
    }
    
    @objc
    func tappedCancleButton() {
        onTappedCancleButton.send()
    }
    
    @objc
    func tappedSaveButton() {
        onTappedSaveButton.send()
    }
    
    @objc
    func tappedClearView() {
        onTappedCancleButton.send()
    }
}
