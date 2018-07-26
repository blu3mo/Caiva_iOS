//
//  Constants.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/05.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    static func get(key: Int) -> UIColor {
        switch key {
        case 0:
            return UIColor(hexString: "6A8BE2")!
        case 1:
            return UIColor(hexString: "D5646F")!
        case 2:
            return UIColor(hexString: "#373D54")!
        case 3:
            return UIColor(hexString: "#73B860")!
        default:
            return UIColor.black
        }
//        switch key {
//        case 0:
//            return (UIColor(hexString: "#4A72E0")!, UIColor(hexString: "#04CCB0")!)
//        case 1:
//            return (UIColor(hexString: "#2B345A")!, UIColor(hexString: "#565E78")!)
//        case 2:
//            return (UIColor(hexString: "#2D9E2F")!, UIColor(hexString: "#CDC447")!)
//        case 3:
//            return (UIColor(hexString: "#A69F1C")!, UIColor(hexString: "#D6D06F")!)
//        default:
//            return (UIColor.black, UIColor.black)
//        }
    }
}

struct GradientKeys {
    static let blue = 0
    static let black = 1
    static let green = 2
    static let orange = 2
}
