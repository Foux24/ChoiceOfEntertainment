//
//  SelectingMovieQueryOptionViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 30.12.2022.
//

import UIKit
import Combine

// MARK: - SelectingMovieQueryOptionViewModel
final class SelectingMovieQueryOptionViewModel {
    
    // MARK: - Public property
    weak var cinemaRequestGenerationViewController: CinemaRequestGenerationViewController?
    var selectRow: String = ""
    let countComponents: Int = 1
    
    // MARK: - Combine property
    @Published var arrayDataFoPickerView = [String]()
    @Published var indexButton: Int
    
    // MARK: - Private property
    private var bag = Set<AnyCancellable>()
    private let constructorParameters: ProtocolRequestParameterConstructorOutput = RequestParameterConstructor()
    private var dictionaryParameters = [String:String]()
    
    // MARK: - Public Funcs
    func saveData() {
        saveParameterInModel(selectRow)
    }
    
    // MARK: - Init
    init(indexButton: Int) {
        self.indexButton = indexButton
        configureListFoPickerView()
        setupDefaultValueSelectRow()
    }
}

// MARK: - Private
private extension SelectingMovieQueryOptionViewModel {
    
    /// Конфигурация данных для пикера
    func configureListFoPickerView() {
        $indexButton
            .map { (indexButton) -> [String] in
                self.dictionaryParameters = self.constructorParameters.fetchParametrs(indexButton)
                return self.configArray(self.dictionaryParameters)
            }
            .assign(to: \.arrayDataFoPickerView, on: self)
            .store(in: &self.bag)
    }
    
    /// Конфигурация массива
    func configArray(_ dictionary: [String:String]) -> [String] {
        sortedIntArray(dictionary.map { $0.key }.sorted { $0 < $1 })
        
    }
    
    /// Сортировка интового массива
    func sortedIntArray(_ array: [String]) -> [String] {
        guard (Int(array.randomElement() ?? "noIntElement") != nil) else { return array }
        let sortArray = array.compactMap { Int($0) }.sorted { $0 < $1 }.map {String($0)}
        return sortArray
    }
    
    /// Сохранения параметров в модель
    func saveParameterInModel(_ selectRow: String) {
        changeTitleButton()
        changeNameButtonInModel()
        let valueDictionary = dictionaryParameters[selectRow]
        switch indexButton {
        case 0:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.typeCinema = valueDictionary
        case 1:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.typeCountry = valueDictionary
        case 2:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.genre = valueDictionary
        case 3:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.typeSorted = valueDictionary
        case 4:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.ratingMin = valueDictionary
        case 5:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.ratingMax = valueDictionary
        case 6:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.yearMin = valueDictionary
        case 7:
            cinemaRequestGenerationViewController?.viewModel.cinemaListDataModel.yearMax = valueDictionary
        default: break
        }
    }
    
    /// Смена тайтла кнопки
    func changeTitleButton() {
        cinemaRequestGenerationViewController?.mainView.changeTitleButton(indexButton, selectRow)
    }
    
    /// Смента имени кнопки в модели
    func changeNameButtonInModel() {
        NameButtonsRequestGenerationViewModel.listNameButtons[indexButton].nameButton = selectRow
    }
    
    /// Установка дефолтного значения для выбранной строки
    func setupDefaultValueSelectRow() {
        $arrayDataFoPickerView
        .sink { [weak self] array in
            guard let self = self else { return }
            let midleIndexArray = array.count / 2
            self.selectRow = array[midleIndexArray]
        }.store(in: &bag)
    }
}
