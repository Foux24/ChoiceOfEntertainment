//
//  DescriptionMovieViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 16.01.2023.
//

import UIKit
import Combine

// MARK: - DescriptionMovieViewController
final class DescriptionMovieViewController: UIViewController {
    
    // MARK: Public properties
    var dismiss: CompletionBlock?
    var viewModel: DescriptionMovieViewModel
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: DescriptionMovieView {
        return self.view as! DescriptionMovieView
    }
    
    // MARK: Init
    init(viewModel: DescriptionMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = DescriptionMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewShotsMovie()
        transitionCollectionViewInCashService()
        binding()
    }
}

//MARK: - UITableViewDataSource
extension DescriptionMovieViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let countSections: Int = 1
        return countSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.listShotsPreviewURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(forIndexPath: indexPath) as ShotsMovieCollectionViewCell
        let image = viewModel.cacheImageService?.photo(atIndexPath: indexPath, byUrl: viewModel.listShotsPreviewURLs[indexPath.row])
        cell.configureImage(with: image)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DescriptionMovieViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            mainView.collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Private
private extension DescriptionMovieViewController {
    
    /// Binding
    func binding() {
        mainView.headerView.onTappedBackButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        viewModel.$descriptionModel
            .sink { [weak self] model in
                guard let self = self else { return }
                self.mainView.configurationView(
                    posterImageURL: model.posterURL ?? "",
                    nameMovie: self.viewModel.fetchNameMovies.fetchNameMovie(model.nameRu, model.nameEn, model.nameOriginal),
                    description: model.description ?? "Нам не удалось найти описание к фильму :(")
            }.store(in: &bag)
        viewModel.$listPreviewURL
            .sink { [weak self] listURLs in
                guard let self = self else { return }
                self.viewModel.listShotsPreviewURLs = listURLs.map {$0.previewURL}
                self.mainView.reloadCollectionView(self.viewModel.listShotsPreviewURLs.count)
            }.store(in: &bag)
    }
    
    /// Настройка коллекции со скриншотами к фильму
    func setupCollectionViewShotsMovie() {
        mainView.collectionView.registerCell(ShotsMovieCollectionViewCell.self)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    /// Передача коллекции в хеш сервис
    func transitionCollectionViewInCashService() {
        viewModel.cacheImageService = CacheImageService(container: mainView.collectionView)
    }
}
