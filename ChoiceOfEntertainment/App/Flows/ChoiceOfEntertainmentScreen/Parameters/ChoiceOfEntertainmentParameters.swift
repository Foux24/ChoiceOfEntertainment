//
//  ChoiceOfEntertainmentParameters.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import Foundation

struct ChoiceOfEntertainmentParameters {
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
