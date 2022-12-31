//
//  SelectingMovieQueryOptionViewController.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 30.12.2022.
//

import UIKit
import Combine

final class SelectingMovieQueryOptionViewController: UIViewController {
    
    // MARK: Public properties
    var viewModel: SelectingMovieQueryOptionViewModel
    var dismiss: CompletionBlock?
    
    // MARK: - Private properties
    private var bag = Set<AnyCancellable>()
    private var mainView: SelectingMovieQueryOptionView {
        return self.view as! SelectingMovieQueryOptionView
    }
    
    // MARK: Init
    /// Инициализторы
    init(viewModel: SelectingMovieQueryOptionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = SelectingMovieQueryOptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        setupPickerView()
    }
}

// MARK: - Extension SelectingMovieQueryOptionViewController on the UIPickerViewDataSource
extension SelectingMovieQueryOptionViewController: UIPickerViewDataSource {

    /// Кол-во компонентов(столбцов) в пикере
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.countComponents
    }

    /// Кол-во строк в пикере
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.arrayDataFoPickerView.count
    }

    /// Текстова компонентов в пикере
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.arrayDataFoPickerView[row]
    }

    /// Цвет компонентов
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(
            string: viewModel.arrayDataFoPickerView[row],
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

// MARK: - Extension SelectingMovieQueryOptionViewController on the UIPickerViewDelegate
extension SelectingMovieQueryOptionViewController: UIPickerViewDelegate {

    /// Выбор компонента в пикере
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectRow = viewModel.arrayDataFoPickerView[row]
    }
}

// MARK: - Private
private extension SelectingMovieQueryOptionViewController {
    /// Binding
    func binding() {
        mainView.onTappedCancleButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss?()
            }.store(in: &bag)
        mainView.onTappedSaveButton
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.saveData()
                self.dismiss?()
            }.store(in: &bag)
    }
    
    /// Setup PickerView
    func setupPickerView() {
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        let midleRow = viewModel.arrayDataFoPickerView.count / 2
        mainView.picker.selectRow(midleRow, inComponent: 0, animated: false)
    }
}
