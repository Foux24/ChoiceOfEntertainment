//
//  CustomNaviHeaderViewParameters.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 27.12.2022.
//

import UIKit

struct CustomNaviHeaderViewParameters {
    
    /// Height View
    static var heightView: CGFloat {
        let model = Device.model
        switch model {
        case .iphoneSE: return 80.0
        default: return 100.0
        }
    }
    
    /// Height and Widht back button
    static var heightAndWidhtBackButton: CGFloat {
        let model = Device.model
        switch model {
        case .iphoneSE: return 40.0
        default: return 50.0
        }
    }
}
