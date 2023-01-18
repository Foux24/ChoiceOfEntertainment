//
//  LastFiveSearchesViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//

import UIKit
import Combine

final class LastFiveSearchesViewController: UIViewController {
    
    // MARK: Public properties
    var dismiss: CompletionBlock?
    var nextScreen: ((CinemaListRequestDataModel) -> ())?
    var viewModel: LastFiveSearchesViewModel

    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: LastFiveSearchesView {
        return self.view as! LastFiveSearchesView
    }
    
    // MARK: Init
    init(viewModel: LastFiveSearchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = LastFiveSearchesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        setupTableView()
    }
}

// MARK: - extension LastFiveSearchesViewController on the UITableViewDataSource
extension LastFiveSearchesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let countSection: Int = 1
        return countSection
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listSearches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(forIndexPath: indexPath) as LastFiveSearchesTableViewCell
        let model = viewModel.listSearches[indexPath.row]
        let typeCinema = viewModel.fetchNameParameter(index: 0, nameParameter: model.typeCinema ?? "")
        let genre = viewModel.fetchNameParameter(index: 2, nameParameter: model.genre ?? "")
        let typeCountry = viewModel.fetchNameParameter(index: 1, nameParameter: model.typeCountry ?? "")
        let ratingMin = viewModel.fetchNameParameter(index: 4, nameParameter: model.ratingMin ?? "")
        let ratingMax = viewModel.fetchNameParameter(index: 5, nameParameter: model.ratingMax ?? "")
        let yearMin = viewModel.fetchNameParameter(index: 6, nameParameter: model.yearMin ?? "")
        let yearMax = viewModel.fetchNameParameter(index: 7, nameParameter: model.yearMax ?? "")
        cell.configurationCell(typeCinema, genre, typeCountry, ratingMin, ratingMax, yearMin, yearMax)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightRow: CGFloat = 0
        return heightRow
    }
}

// MARK: - extension LastFiveSearchesViewController on the UITableViewDelegate
extension LastFiveSearchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.listProperties = viewModel.convertCDModel(viewModel.listSearches[indexPath.row])
        mainView.searchButton.setTitleColor(.white, for: .normal)
    }
}

// MARK: - Private
private extension LastFiveSearchesViewController {
    /// Binding
    func binding() {
        mainView.onTappedCancleButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        mainView.onTappedSearchButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                guard let listProperties = self.viewModel.listProperties else { return }
                self.dismiss?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.nextScreen?(listProperties)
                }
            }.store(in: &bag)
        viewModel.$listSearches
            .sink { [weak self] listSearch in
                guard let self = self else { return }
                self.mainView.tableView.reloadData()
                if listSearch.count > 0 {
                    self.mainView.notSearch.isHidden = true
                }
            }.store(in: &bag)
        
    }
    
    /// Setup TableView
    func setupTableView() {
        mainView.tableView.registerCell(LastFiveSearchesTableViewCell.self)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}
