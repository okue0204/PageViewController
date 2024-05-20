//
//  Tag.swift
//  PageViewController
//
//  Created by 奥江英隆 on 2024/05/22.
//

import Foundation
import UIKit

enum Tag: Int, CaseIterable {
    case number1
    case number2
    case number3
    case number4
    case number5
    
    var title: String {
        switch self {
        case .number1:
            "number1"
        case .number2:
            "number2"
        case .number3:
            "number3"
        case .number4:
            "number4"
        case .number5:
            "number5"
        }
    }
    
    var color: UIColor {
        switch self {
        case .number1:
            UIColor.systemMint
        case .number2:
            UIColor.orange
        case .number3:
            UIColor.yellow
        case .number4:
            UIColor.purple
        case .number5:
            UIColor.green
        }
    }
}
