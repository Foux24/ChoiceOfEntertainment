//
//  DescriptionMovieView.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import UIKit

// MARK: - DescriptionMovieView
final class DescriptionMovieView: UIView {
    
    // MARK: - Private Properties
    private(set) lazy var headerView: CustomNaviHeaderView = {
        let view = CustomNaviHeaderView()
        view.titleLabel.text = "Кино"
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let blurredView: BlurredView = {
        let view = BlurredView(intensity: 0.2)
        view.backgroundColor = .blackAlpha70
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let nameMovie: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        return label
    }()
    
    private let descriptionMovie: UILabel = {
        let label = UILabel()
        label.textColor = .whiteAlpha70
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: .current)
        return label
    }()
    
    func configurationView(posterImageURL: String, nameMovie: String, description: String) {
        posterImageView.loadImage(posterImageURL)
        self.nameMovie.text = nameMovie
        descriptionMovie.text = description
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
private extension DescriptionMovieView {
    
    /// Настройка view
    func setupView() -> Void {
        self.backgroundColor = .appBackground
    }
    
    /// Добавление UI на View
    func addUIInView() -> Void {
        addSubview(headerView)
        addSubview(posterImageView)
        posterImageView.addSubview(blurredView)
        addSubview(scrollView)
        scrollView.addSubview(nameMovie)
        scrollView.addSubview(descriptionMovie)
    }
    
    /// Установка констрейнтов
    func setupConstreints() -> Void {
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        blurredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        nameMovie.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        descriptionMovie.snp.makeConstraints { make in
            make.top.equalTo(nameMovie.snp.bottom).inset(-10)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
}
