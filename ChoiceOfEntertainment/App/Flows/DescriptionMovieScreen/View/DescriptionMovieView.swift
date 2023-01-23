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
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayoutCollection())
        collection.backgroundColor = .clear
        collection.isPagingEnabled = false
        return collection
    }()
    
    func configurationView(posterImageURL: String, nameMovie: String, description: String) {
        posterImageView.loadImage(posterImageURL)
        self.nameMovie.text = nameMovie
        descriptionMovie.text = description
    }
    
    // FIXME: - Сделать логику отображения коллекции если итемов в ней ноль
    func reloadCollectionView(_ countItem: Int) {
        collectionView.reloadData()
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
        scrollView.addSubview(collectionView)
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
            make.leading.equalTo(self.snp.leading).inset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionMovie.snp.bottom).inset(-5)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(142)
            make.bottom.equalToSuperview()
        }
    }
    
    /// Настроим композицию элементов в коллекции
    func createLayoutCollection() -> UICollectionViewLayout {
        var widhtGroup: CGFloat {
            let model = Device.model
            switch model {
            case .iphoneSE: return 1.14
            default: return 0.885
            }
        }
        let spacing: CGFloat = 5
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(180),
            heightDimension: .absolute(132))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(widhtGroup),
            heightDimension: .absolute(132))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
