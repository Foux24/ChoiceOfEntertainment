//
//  SelectMovieScreenTableViewCell.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 11.01.2023.
//

import UIKit

final class SelectMovieScreenTableViewCell: UITableViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: SelectMovieScreenTableViewCell.self)
    
    private let previewImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()

    private let nameMovie: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let genres: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let year: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    /// Конфигурация ячейки
    func configurationCell(
        nameMovie: String,
        image: UIImage?,
        genre: String,
        year: String,
        rating: String) {
            self.nameMovie.text = nameMovie
            self.previewImage.image = image ?? UIImage(named: "noPoster")
            self.genres.text = genre
            self.year.text = "Год - \(year)"
            self.rating.text = "Рейтинг - \(rating)"
            setupCell()
            addUIInView()
            setupConstreints()
        }
}

private extension SelectMovieScreenTableViewCell {
    /// Настройка ячейки
    func setupCell() {
        self.backgroundColor = .clear
    }
    
    /// Добавление UI
    func addUIInView() -> Void {
        contentView.addSubview(nameMovie)
        contentView.addSubview(previewImage)
        contentView.addSubview(genres)
        contentView.addSubview(year)
        contentView.addSubview(rating)
    }
    
    /// Раставим констрейнты
    func setupConstreints() -> Void {
        previewImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(5)
            make.height.equalTo(100)
            make.width.equalTo(75)
        }
        nameMovie.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.top)
            make.leading.equalTo(previewImage.snp.trailing).inset(-5)
            make.trailing.equalToSuperview().inset(5)
        }
        genres.snp.makeConstraints { make in
            make.top.equalTo(nameMovie.snp.bottom).inset(-5)
            make.leading.equalTo(nameMovie.snp.leading)
            make.trailing.equalToSuperview().inset(5)
        }
        year.snp.makeConstraints { make in
            make.top.equalTo(genres.snp.bottom).inset(-5)
            make.leading.equalTo(nameMovie.snp.leading)
        }
        rating.snp.makeConstraints { make in
            make.centerY.equalTo(year.snp.centerY)
            make.leading.equalTo(year.snp.trailing).inset(-15)
        }
    }
}
