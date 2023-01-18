//
//  LastFiveSearchesTableViewCell.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//

import UIKit

final class LastFiveSearchesTableViewCell: UITableViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: LastFiveSearchesTableViewCell.self)
    
    private let nameSearch: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: .current)
        return label
    }()
    
    private let selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha15
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let demarcationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteAlpha25
        view.layer.cornerRadius = 1 / 2
        return view
    }()
    
    /// Конфигурация ячейки
    func configurationCell(_ typeCinema: String,_ genre: String,_ typeCountry: String,_ ratingMin: String,_ ratingMax: String,_ yearMin: String,_ yearMax: String) {
        nameSearch.text = "\(typeCinema), \(genre), \(typeCountry)\nРейтинг \(ratingMin)-\(ratingMax), Год: \(yearMin)-\(yearMax) "
        setupCell()
        addUIInView()
        setupConstreints()
    }
}

private extension LastFiveSearchesTableViewCell {
    
    /// Настройка ячейки
    func setupCell() {
        self.backgroundColor = .clear
        self.selectedBackgroundView = selectionView
    }
    
    /// Добавление UI
    func addUIInView() -> Void {
        contentView.addSubview(nameSearch)
        contentView.addSubview(demarcationLine)
    }
    
    /// Раставим констрейнты
    func setupConstreints() -> Void {
        nameSearch.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        demarcationLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}

