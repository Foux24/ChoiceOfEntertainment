//
//  Device.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

enum Device: String {
    /// iPhone 6s, iPhone 7, iPhoneSE2gen
    case iphone8
    /// IPhone 8 plus
    case iphone8plus
    /// iPhone X, iPhone 11 Pro, iPhone 12 Mini, iPhone 13 Mini
    case iphoneXS
    /// iPhone XS Max, iPhone XR, iPhone 11, iPhone 11 Pro Max
    case iphoneXR
    /// iPhone 12 Pro, iPhone 13, iPhone 14, iPhone 13 Pro, iPhone 14 Pro
    case iphone12
    /// iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Plus, iPhone 14 Pro Max
    case iphone12ProMax
    /// IPhone SE1gen
    case iphoneSE
    /// iPhone 7 Plus
    case iphone6Splus
    
    static var model: Device = {
        let size = UIScreen.main.bounds.size
        if size.height > 926.0 {
            return .iphone12ProMax
        }
        switch size {
        case CGSize(width: 320.0, height: 568.0):
            return .iphoneSE
        case CGSize(width: 375, height: 667):
            return .iphone8
        case CGSize(width: 476.0, height: 847.0):
            return .iphone6Splus
        case CGSize(width: 414.0, height: 736.0):
            return .iphone8plus
        case CGSize(width: 375.0, height: 812.0):
            return .iphoneXS
        case CGSize(width: 414.0, height: 896.0):
            return .iphoneXR
        case CGSize(width: 390.0, height: 844.0):
            return .iphone12
        case CGSize(width: 428.0, height: 926.0):
            return .iphone12ProMax
        case CGSize(width: 393.0, height: 852.0):
            return .iphone12
        default:
            return .iphoneSE
        }
    }()
}
