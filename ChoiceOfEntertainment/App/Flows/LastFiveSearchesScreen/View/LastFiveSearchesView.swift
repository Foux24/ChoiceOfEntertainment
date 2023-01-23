//
//  LastFiveSearchesView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//

import UIKit
import Combine

final class LastFiveSearchesView: UIView {
    
    // MARK: - Combine Property
    let onTappedSearchButton = PassthroughSubject<Void, Never>()
    let onTappedCancleButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Private property
    private(set) lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Повторить поиск", for: .normal)
        button.setTitleColor(.whiteAlpha50, for: .normal)
        return button
    }()
    
    private let cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private(set) lazy var notSearch: UILabel = {
        let label = UILabel()
        label.text = "Извините\nВы раньше ничего не искали"
        label.textColor = .whiteAlpha50
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let historySearch: UILabel = {
        let label = UILabel()
        label.textColor = .whiteAlpha15
        label.textAlignment = .center
        label.text = "Истрия поиска"
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 0
        return tableView
    }()
    
    private let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let viewUnderTableView: UIView = {
        let view = UIView()
        view.backgroundColor = .pickerViewBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let demarcationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha50
        return view
    }()
    
    private let magnifying: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")
        view.tintColor = .white
        view.layer.opacity = 0.1
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
private extension LastFiveSearchesView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .clear
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(clearView)
        addSubview(viewUnderTableView)
        
        viewUnderTableView.addSubview(cancleButton)
        viewUnderTableView.addSubview(searchButton)
        viewUnderTableView.addSubview(magnifying)
        viewUnderTableView.addSubview(tableView)
        viewUnderTableView.addSubview(historySearch)
        viewUnderTableView.addSubview(notSearch)
        viewUnderTableView.addSubview(demarcationLine)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        clearView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(100)
        }
        viewUnderTableView.snp.makeConstraints { make in
            make.top.equalTo(clearView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        magnifying.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.center.equalToSuperview()
        }
        cancleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        historySearch.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        demarcationLine.snp.makeConstraints { make in
            make.top.equalTo(cancleButton.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(demarcationLine.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        notSearch.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /// Добавление таргетов на UI
    func addTargetsInUI() {
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
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
    func tappedSearchButton() {
        onTappedSearchButton.send()
    }
    
    @objc
    func tappedClearView() {
        onTappedCancleButton.send()
    }
}
