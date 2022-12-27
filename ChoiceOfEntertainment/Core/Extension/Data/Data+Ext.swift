//
//  Data+Ext.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

extension Data {
    
    /// Загрузка данных из файла, возвращает готовую Data
    ///  - Parameter nameFile: Имя файла JSON
    ///  Возвращает Data
    func loadDataJson(_ nameFile: String) -> Data {
        let path1 = Bundle.main.path(forResource: nameFile, ofType: "json")!
        let url = URL(fileURLWithPath: path1)
        let data = try! Data(contentsOf: url)
        return data
    }
}
