//
//  ShotsMovieCollectionViewCell.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 20.01.2023.
//

import UIKit
import SnapKit

final class ShotsMovieCollectionViewCell: UICollectionViewCell {
    
    /// Ключ для регистрации ячкйки
    static let reuseID = String(describing: ShotsMovieCollectionViewCell.self)

    private let shotsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    /// Конфигурирует ячейку
    func configureImage(with image: UIImage?) {
        shotsImage.image = image ?? UIImage(named: "noImage")
        addUIInView()
        setupConstreints()
    }
    
}

// MARK: - Private
private extension ShotsMovieCollectionViewCell {
    
    /// Метод  добавления UIImage в ячейку
    func addUIInView() {
        contentView.addSubview(shotsImage)
    }
    
    /// Метод установки констрейнтов
    func setupConstreints() {
        shotsImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
