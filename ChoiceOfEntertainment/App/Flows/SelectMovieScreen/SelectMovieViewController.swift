//
//  SelectMovieViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 09.01.2023.
//

import UIKit
import Combine

// MARK: - SelectMovieViewController
final class SelectMovieViewController: UIViewController {
    
    // MARK: Public properties
    var dismiss: CompletionBlock?
    var viewModel: SelectMovieViewModel
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: SelectMovieView {
        return self.view as! SelectMovieView
    }
    
    // MARK: Init
    init(viewModel: SelectMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = SelectMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        transitionTableViewInCashService()
        binding()
    }
}

// MARK: - extension SelectMovieViewController on the UITableViewDataSource
extension SelectMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.countSection
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listMovie.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(forIndexPath: indexPath) as SelectMovieScreenTableViewCell
        let movie = viewModel.listMovie[indexPath.row]
        let image = viewModel.cacheImageService?.photo(atIndexPath: indexPath, byUrl: movie.posterURLPreview ?? "")
        cell.configurationCell(
            nameMovie: movie.nameRu ?? "noName",
            image: image,
            genre: viewModel.fetchListGengre(genres: movie.genres),
            year: String(movie.year ?? 1980),
            rating: String(movie.ratingKinopoisk ?? 0.0))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - extension SelectMovieViewController on the UITableViewDelegate
extension SelectMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension SelectMovieViewController on the DataSourcePrefetching
extension SelectMovieViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.loadMovies(indexPaths: indexPaths)
    }
}

// MARK: - Private
private extension SelectMovieViewController {
    
    /// Передача таблицы в хеш сервис
    func transitionTableViewInCashService() {
        viewModel.cacheImageService = CacheImageService(container: mainView.tableView)
    }
    
    /// Настройка таблицы
    func setupTableView() {
        mainView.tableView.registerCell(SelectMovieScreenTableViewCell.self)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.prefetchDataSource = self
    }
    
    /// Binding
    func binding() {
        mainView.headerView.onTappedBackButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        viewModel.$movieModel
            .sink { [weak self] movieModel in
                guard let self = self else { return }
                self.viewModel.listMovie.append(contentsOf: movieModel.items)
                self.mainView.tableView.reloadData()
                self.viewModel.isLoading = false
            }.store(in: &bag)
    }
}
