//
//  TableViewCell+Ext.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 11.01.2023.
//

import UIKit

/// Протокол Reusable
protocol Reusable{}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    /// Регистрация чейки
    /// - Parameter cellClass: Передаем тип ячейки
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseID)
    }
    
    /// Приводим ячйку к типу
    /// - Parameter indexPath: Индекс ячейки
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else { fatalError("Fatal error for cell at \(indexPath))") }
        return cell
    }
}
