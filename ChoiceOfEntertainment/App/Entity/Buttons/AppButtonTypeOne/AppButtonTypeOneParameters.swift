//
//  AppButtonTypeOneParameters.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 29.12.2022.
//

import Foundation

struct AppButtonTypeOneParameters {
    
    /// Widht button
    static var widhtButton: CGFloat {
        let model = Device.model
        switch model {
        case .iphoneSE: return 250.0
        default: return 300.0
        }
    }
    
    /// Height Button
    static var heightButton: CGFloat {
        let model = Device.model
        switch model {
        case .iphoneSE: return 40.0
        default: return 50.0
        }
    }
}
