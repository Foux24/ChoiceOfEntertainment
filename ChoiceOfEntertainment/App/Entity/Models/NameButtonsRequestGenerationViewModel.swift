//
//  NameButtonsRequestGenerationViewModel.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 29.12.2022.
//

import Foundation

// MARK: - NameButtonsRequestGenerationViewModel
struct NameButtonsRequestGenerationViewModel {
    var nameButton: String
    var indexButton: Int
}

// MARK: Extension struct creat list name buttons
extension NameButtonsRequestGenerationViewModel {
    static var listNameButtons = [
    NameButtonsRequestGenerationViewModel(nameButton: "Тип фильма", indexButton: 0),
    NameButtonsRequestGenerationViewModel(nameButton: "Страна", indexButton: 1),
    NameButtonsRequestGenerationViewModel(nameButton: "Жанр", indexButton: 2),
    NameButtonsRequestGenerationViewModel(nameButton: "Сортировка", indexButton: 3),
    NameButtonsRequestGenerationViewModel(nameButton: "Рейтинг min", indexButton: 4),
    NameButtonsRequestGenerationViewModel(nameButton: "Рейтинг max", indexButton: 5),
    NameButtonsRequestGenerationViewModel(nameButton: "Год min", indexButton: 6),
    NameButtonsRequestGenerationViewModel(nameButton: "Год max", indexButton: 7)
    ]
}
