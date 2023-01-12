//
//  CustomLoadView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 12.01.2023.
//

import UIKit
import SnapKit

// MARK: - CustomLoadView
final class CustomLoadView: UIView {
    
    // MARK: - Private Properties
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .loadViewBackground
        view.layer.cornerRadius = 40
        return view
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Пожалуйста подождите..."
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Извините :(\nЧто-то пошло не так"
        label.isHidden = true
        return label
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        return indicator
    }()
    
    /// Старт загрузки
    func startLoadView() {
        indicator.startAnimating()
        titleView.isHidden = false
        errorLabel.isHidden = true
        isHidden = false
        errorLoad()
    }
    
    /// Остановка загрузки
    func stopLoadView() {
        indicator.stopAnimating()
        isHidden = true
    }
    
    /// Ошибка загрузки
    func errorLoadView() {
        indicator.stopAnimating()
        titleView.isHidden = true
        errorLabel.isHidden = false
    }
    
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
private extension CustomLoadView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .clear
        indicator.startAnimating()
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(mainView)
        mainView.addSubview(titleView)
        mainView.addSubview(indicator)
        mainView.addSubview(errorLabel)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        titleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(15)
        }
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /// Ошибка загрузки
    func errorLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.errorLoadView()
        }
    }
}
