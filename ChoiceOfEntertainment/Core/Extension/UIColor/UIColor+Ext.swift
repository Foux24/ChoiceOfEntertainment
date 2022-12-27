//
//  UIColor+Ext.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        let firstSombol = "#"
        
        if hexString.hasPrefix(firstSombol) {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: firstSombol)
        }

        var hex: CUnsignedLongLong = 0
        scanner.scanHexInt64(&hex)

        let mask = 0x000000FF
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    static let appBackground = UIColor(hexString: "#131718")
    static let whiteAlpha10 = UIColor(white: 1, alpha: 0.1)
    static let whiteAlpha50 = UIColor(white: 1, alpha: 0.5)
}
