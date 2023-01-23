//
//  CollectionViewCell.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 20.01.2023.
//

import UIKit

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
extension UICollectionView {
    
    /// Регистрация чейки
    /// - Parameter cellClass: Передаем тип ячейки
    func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseID)
    }
    
    /// Приводим ячйку к типу
    /// - Parameter indexPath: Индекс ячейки
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath)
                as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }
        return cell
    }
}
